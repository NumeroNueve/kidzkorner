import AVFoundation

enum VoiceHelper {
    static var preferredVoice: AVSpeechSynthesisVoice? = {
        let voices = AVSpeechSynthesisVoice.speechVoices()
        if let ava = voices.first(where: { $0.name == "Ava (Enhanced)" }) {
            return ava
        }
        if let ava = voices.first(where: { $0.name.hasPrefix("Ava") }) {
            return ava
        }
        return AVSpeechSynthesisVoice(language: "en-US")
    }()
}
