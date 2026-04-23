import Foundation
import AVFoundation

enum ElevenLabsTTS {
    static let defaultVoiceID = "2OEeJcYw2f3bWMzzjVMU"

    static func synthesize(text: String, voiceID: String = defaultVoiceID) async throws -> Data {
        let url = URL(string: "\(APIConfig.proxyBaseURL)/api/tts?voiceID=\(voiceID)")!

        let body: [String: Any] = [
            "text": text,
            "model_id": "eleven_flash_v2_5",
            "voice_settings": [
                "stability": 0.6,
                "similarity_boost": 0.75,
            ]
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
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
        case apiError
    }
}
