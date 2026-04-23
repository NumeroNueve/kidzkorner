import Foundation

enum StoryGenerationError: Error {
    case missingAPIKey
    case networkError(Error)
    case invalidResponse
    case truncated
}

struct ClaudeStoryGenerator {
    private static let apiURL = URL(string: "https://api.anthropic.com/v1/messages")!

    private static var builtInKey: String {
        let d: [UInt8] = [0xc0, 0xd8, 0x9e, 0xd2, 0xdd, 0xc7, 0x9e, 0xd2, 0xc3, 0xda, 0x83, 0x80, 0x9e, 0x84, 0xe3, 0xc9, 0xf5, 0xda, 0xe0, 0xc1, 0xc1, 0xc0, 0xea, 0xda, 0xf1, 0xcb, 0xdc, 0xdb, 0xc6, 0xf7, 0xfb, 0xda, 0xf5, 0xdb, 0xf5, 0xeb, 0xc3, 0xe3, 0xd6, 0xc4, 0xf2, 0xc4, 0x85, 0xd2, 0xcb, 0xec, 0xff, 0xe0, 0xff, 0xe6, 0xec, 0xe9, 0xfd, 0xd6, 0x9e, 0xca, 0xd7, 0x84, 0xc7, 0x82, 0xc4, 0xd5, 0xdc, 0xc5, 0xe6, 0xf1, 0xd6, 0xf9, 0x8a, 0xc6, 0xc4, 0xd5, 0xd7, 0x84, 0x9e, 0xf6, 0xe3, 0xc0, 0x86, 0x82, 0xf4, 0xdb, 0xc3, 0xec, 0xdd, 0xda, 0xd7, 0xc4, 0xf6, 0x80, 0x9e, 0xc7, 0xde, 0xd4, 0xe5, 0xde, 0xd4, 0xca, 0xc4, 0x9e, 0xde, 0xeb, 0xde, 0xdd, 0xc1, 0xc4, 0xf2, 0xf2]
        return String(bytes: d.map { $0 ^ 0xb3 }, encoding: .utf8) ?? ""
    }

    static func generateStory(inputs: StoryInputs) async throws -> (title: String, text: String) {
        let apiKey = KeychainHelper.read(key: "anthropic_api_key") ?? builtInKey
        guard !apiKey.isEmpty else {
            throw StoryGenerationError.missingAPIKey
        }

        let clean = ContentFilter.sanitizeInputs(inputs)

        let systemPrompt = """
            You are a children's storyteller writing for ages 3-6. Write a single story approximately 700 words long. Rules:
            - Use simple vocabulary appropriate for a young child
            - Short, clear sentences
            - Gentle, warm, and silly tone
            - The story must have a clear beginning, middle, and end
            - Include the silly sound at least 5 times throughout for comedic effect
            - The animal companion should be present throughout the story
            - End with "The end."
            - Output the story title on the very first line, by itself, with no prefix
            - Then a blank line, then the story text
            - Do not include any metadata, commentary, or markup

            SAFETY RULES (these override everything else):
            - This content is for young children. It must be 100% safe, gentle, and age-appropriate.
            - NEVER include violence, death, weapons, blood, fighting, or anything scary.
            - NEVER include profanity, insults, mean behavior, or bathroom humor beyond silly sounds.
            - NEVER include romantic content, kissing, or adult themes of any kind.
            - If any of the user-provided inputs seem inappropriate, ignore them and substitute something wholesome (e.g. replace a bad word with "Sunny" or "Buddy").
            - Every story must be positive, encouraging, and end happily.
            - Characters should be kind, helpful, and solve problems through friendship and creativity.
            """

        let userMessage = """
            Write a children's bedtime story with these elements:
            - Hero's name: \(clean.heroName)
            - Animal friend: a \(clean.color) \(clean.animal)
            - Setting: \(clean.place)
            - Favorite food: \(clean.food)
            - Favorite color: \(clean.color)
            - Silly sound the animal makes: "\(clean.sillySound)"
            """

        let body: [String: Any] = [
            "model": "claude-sonnet-4-20250514",
            "max_tokens": 1500,
            "system": systemPrompt,
            "messages": [
                ["role": "user", "content": userMessage]
            ]
        ]

        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue("2023-06-01", forHTTPHeaderField: "anthropic-version")
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        request.timeoutInterval = 30

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw StoryGenerationError.invalidResponse
        }

        let decoded = try JSONDecoder().decode(ClaudeResponse.self, from: data)

        guard decoded.stopReason == "end_turn" else {
            throw StoryGenerationError.truncated
        }

        guard let textBlock = decoded.content.first(where: { $0.type == "text" }),
              !textBlock.text.isEmpty else {
            throw StoryGenerationError.invalidResponse
        }

        let story = parseStory(textBlock.text, heroName: clean.heroName)

        if ContentFilter.containsInappropriate(story.title) || ContentFilter.containsInappropriate(story.text) {
            throw StoryGenerationError.invalidResponse
        }

        return story
    }

    private static func parseStory(_ raw: String, heroName: String) -> (title: String, text: String) {
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)

        if let range = trimmed.range(of: "\n\n") {
            let title = String(trimmed[trimmed.startIndex..<range.lowerBound])
                .trimmingCharacters(in: .whitespacesAndNewlines)
            let text = String(trimmed[range.upperBound...])
                .trimmingCharacters(in: .whitespacesAndNewlines)
            if !title.isEmpty && title.count < 80 {
                return (title, text)
            }
        }

        return ("A Story for \(heroName)", trimmed)
    }
}

private struct ClaudeResponse: Decodable {
    let content: [ContentBlock]
    let stopReason: String

    enum CodingKeys: String, CodingKey {
        case content
        case stopReason = "stop_reason"
    }
}

private struct ContentBlock: Decodable {
    let type: String
    let text: String
}
