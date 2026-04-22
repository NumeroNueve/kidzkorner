import SwiftUI
import AVFoundation

enum StoryState {
    case loading
    case ready(title: String, text: String)
}

struct StoryPlaybackView: View {
    let inputs: StoryInputs

    @State private var storyState: StoryState = .loading
    @State private var speaker = StorySpeaker()
    @State private var showCelebration = false
    @Environment(\.dismiss) private var dismiss

    private var storyTitle: String {
        if case .ready(let title, _) = storyState { return title }
        return ""
    }

    private var storyText: String {
        if case .ready(_, let text) = storyState { return text }
        return ""
    }

    private var isReady: Bool {
        if case .ready = storyState { return true }
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

        if NetworkMonitor.shared.isConnected {
            do {
                let result = try await ClaudeStoryGenerator.generateStory(inputs: inputs)
                storyState = .ready(title: result.title, text: result.text)
                return
            } catch {
                // Fall through to local template
            }
        }

        let template = StoryTemplate.random()
        storyState = .ready(title: template.title, text: template.build(inputs))
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
                    speaker.speak(storyText) {
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
    var isSpeaking = false
    var isSlowMode = false
    private var onFinish: (() -> Void)?

    override init() {
        super.init()
        synthesizer.delegate = self
    }

    func speak(_ text: String, onFinish: @escaping () -> Void) {
        stop()
        self.onFinish = onFinish

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = VoiceHelper.preferredVoice
        utterance.rate = isSlowMode ? 0.35 : 0.48
        utterance.pitchMultiplier = 1.1
        utterance.preUtteranceDelay = 0.3

        isSpeaking = true
        synthesizer.speak(utterance)
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        isSpeaking = false
        onFinish = nil
    }

    func toggleSpeed() {
        isSlowMode.toggle()
        if isSpeaking {
            let wasFinish = onFinish
            stop()
            if let finish = wasFinish {
                onFinish = finish
            }
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isSpeaking = false
        onFinish?()
        onFinish = nil
    }
}
