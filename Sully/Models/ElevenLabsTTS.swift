import Foundation
import AVFoundation

enum ElevenLabsTTS {
    static let defaultVoiceID = "2OEeJcYw2f3bWMzzjVMU"

    private static var apiKey: String {
        let d: [UInt8] = [0xd4, 0xcc, 0xf8, 0x91, 0x9e, 0x96, 0x96, 0xc3, 0x94, 0xc5, 0x9f, 0x90, 0xc1, 0x90, 0x92, 0x9f, 0x9f, 0x9e, 0xc1, 0xc2, 0xc6, 0x9f, 0xc1, 0xc2, 0x91, 0x90, 0xc4, 0x97, 0x92, 0x97, 0x96, 0x91, 0x90, 0x91, 0xc5, 0x91, 0xc5, 0xc6, 0x91, 0x97, 0xc1, 0x9f, 0x94, 0xc4, 0x90, 0x9f, 0x95, 0x91, 0x9e, 0x95, 0x9e]
        return String(bytes: d.map { $0 ^ 0xa7 }, encoding: .utf8) ?? ""
    }

    static func synthesize(text: String, voiceID: String = defaultVoiceID) async throws -> Data {
        let key = apiKey
        guard !key.isEmpty else {
            throw TTSError.missingAPIKey
        }

        let url = URL(string: "https://api.elevenlabs.io/v1/text-to-speech/\(voiceID)")!

        let body: [String: Any] = [
            "text": text,
            "model_id": "eleven_monolingual_v1",
            "voice_settings": [
                "stability": 0.6,
                "similarity_boost": 0.75,
            ]
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(key, forHTTPHeaderField: "xi-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("audio/mpeg", forHTTPHeaderField: "Accept")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        request.timeoutInterval = 60

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw TTSError.apiError
        }

        return data
    }

    enum TTSError: Error {
        case missingAPIKey
        case apiError
    }
}
