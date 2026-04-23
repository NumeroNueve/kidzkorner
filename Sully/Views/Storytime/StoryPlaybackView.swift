import SwiftUI
import AVFoundation

enum StoryState {
    case loading
    case generatingVoice(title: String, text: String)
    case ready(title: String, text: String, audioData: Data?)
}

struct StoryPlaybackView: View {
    let inputs: StoryInputs

    @State private var storyState: StoryState = .loading
    @State private var speaker = StorySpeaker()
    @State private var showCelebration = false
    @Environment(\.dismiss) private var dismiss

    private var storyTitle: String {
        if case .ready(let title, _, _) = storyState { return title }
        return ""
    }

    private var storyText: String {
        if case .ready(_, let text, _) = storyState { return text }
        return ""
    }

    private var storyAudioData: Data? {
        if case .ready(_, _, let data) = storyState { return data }
        return nil
    }

    private var isReady: Bool {
        if case .ready = storyState { return true }
        return false
    }

    private var isGeneratingVoice: Bool {
        if case .generatingVoice = storyState { return true }
        return false
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.1, green: 0.1, blue: 0.3), Color(red: 0.2, green: 0.05, blue: 0.35)],
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea()

            if isReady {
                VStack(spacing: 0) {
                    titleSection
                    storyScroll
                    controls
                }
            } else if isGeneratingVoice {
                VStack(spacing: 20) {
                    ProgressView()
                        .scaleEffect(2)
                        .tint(.white)
                    Text("Getting the storyteller ready...")
                        .font(.system(size: 22, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.8))
                }
            } else {
                StoryLoadingView()
            }

            if showCelebration {
                CelebrationView {
                    showCelebration = false
                }
            }
        }
        .navigationTitle("Storytime")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color(red: 0.1, green: 0.1, blue: 0.3), for: .navigationBar)
        .task {
            await loadStory()
        }
        .onDisappear {
            speaker.stop()
        }
    }

    private func loadStory() async {
        storyState = .loading
        speaker.stop()

        var title: String
        var text: String

        if NetworkMonitor.shared.isConnected {
            do {
                let result = try await ClaudeStoryGenerator.generateStory(inputs: inputs)
                title = result.title
                text = result.text
            } catch {
                let template = StoryTemplate.random()
                title = template.title
                text = template.build(inputs)
            }
        } else {
            let template = StoryTemplate.random()
            title = template.title
            text = template.build(inputs)
        }

        storyState = .generatingVoice(title: title, text: text)

        var audioData: Data?
        do {
            audioData = try await ElevenLabsTTS.synthesize(text: text)
        } catch {
            // Will fall back to Apple TTS on playback
        }

        storyState = .ready(title: title, text: text, audioData: audioData)
    }

    private var titleSection: some View {
        VStack(spacing: 8) {
            Text("📖")
                .font(.system(size: 50))
            Text(storyTitle)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(.yellow)
            Text("Starring \(inputs.heroName)!")
                .font(.system(size: 20, weight: .medium, design: .rounded))
                .foregroundStyle(.white.opacity(0.8))
        }
        .padding(.top, 12)
        .padding(.bottom, 8)
    }

    private var storyScroll: some View {
        ScrollView {
            Text(storyText)
                .font(.system(size: 22, weight: .regular, design: .rounded))
                .foregroundStyle(.white)
                .lineSpacing(8)
                .padding(24)
        }
        .background(.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 16)
    }

    private var controls: some View {
        HStack(spacing: 24) {
            Button {
                Task { await loadStory() }
            } label: {
                VStack(spacing: 4) {
                    Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                        .font(.system(size: 28))
                    Text("New Story")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                }
                .foregroundStyle(.white.opacity(0.8))
                .frame(width: 80)
            }

            Button {
                if speaker.isSpeaking {
                    speaker.stop()
                } else {
                    speaker.speak(storyText, audioData: storyAudioData) {
                        showCelebration = true
                    }
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(speaker.isSpeaking ? Color.red.gradient : Color.green.gradient)
                        .frame(width: 90, height: 90)
                        .shadow(color: speaker.isSpeaking ? .red.opacity(0.4) : .green.opacity(0.4),
                                radius: 10, y: 4)

                    Image(systemName: speaker.isSpeaking ? "stop.fill" : "play.fill")
                        .font(.system(size: 36))
                        .foregroundStyle(.white)
                }
            }

            VStack(spacing: 4) {
                Image(systemName: "tortoise.fill")
                    .font(.system(size: 28))
                Text(speaker.isSlowMode ? "Slow" : "Normal")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
            }
            .foregroundStyle(speaker.isSlowMode ? .yellow : .white.opacity(0.8))
            .frame(width: 80)
            .onTapGesture {
                speaker.toggleSpeed()
            }
        }
        .padding(.vertical, 16)
    }
}

@Observable
class StorySpeaker: NSObject, AVSpeechSynthesizerDelegate, @unchecked Sendable {
    private let synthesizer = AVSpeechSynthesizer()
    private var audioPlayer: AVAudioPlayer?
    var isSpeaking = false
    var isSlowMode = false
    private var onFinish: (() -> Void)?
    private var currentText: String?
    private var usingElevenLabs = false

    override init() {
        super.init()
        synthesizer.delegate = self
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio)
    }

    func speak(_ text: String, audioData: Data? = nil, onFinish: @escaping () -> Void) {
        stop()
        self.onFinish = onFinish
        self.currentText = text
        isSpeaking = true

        if let audioData = audioData {
            playElevenLabsAudio(audioData)
        } else {
            speakWithApple(text)
        }
    }

    private func playElevenLabsAudio(_ data: Data) {
        usingElevenLabs = true
        try? AVAudioSession.sharedInstance().setActive(true)
        do {
            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer?.delegate = self
            if isSlowMode {
                audioPlayer?.enableRate = true
                audioPlayer?.rate = 0.75
            }
            audioPlayer?.play()
        } catch {
            if let text = currentText {
                speakWithApple(text)
            }
        }
    }

    private func speakWithApple(_ text: String) {
        usingElevenLabs = false
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = VoiceHelper.preferredVoice
        utterance.rate = isSlowMode ? 0.35 : 0.48
        utterance.pitchMultiplier = 1.1
        utterance.preUtteranceDelay = 0.3
        synthesizer.speak(utterance)
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        audioPlayer?.stop()
        audioPlayer = nil
        isSpeaking = false
        currentText = nil
        onFinish = nil
    }

    func toggleSpeed() {
        isSlowMode.toggle()
        if isSpeaking, usingElevenLabs, let player = audioPlayer {
            player.enableRate = true
            player.rate = isSlowMode ? 0.75 : 1.0
        } else if isSpeaking {
            let text = currentText
            let wasFinish = onFinish
            stop()
            if let text = text, let finish = wasFinish {
                self.onFinish = finish
                self.currentText = text
                isSpeaking = true
                speakWithApple(text)
            }
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isSpeaking = false
        onFinish?()
        onFinish = nil
    }
}

extension StorySpeaker: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        Task { @MainActor in
            isSpeaking = false
            onFinish?()
            onFinish = nil
        }
    }
}
