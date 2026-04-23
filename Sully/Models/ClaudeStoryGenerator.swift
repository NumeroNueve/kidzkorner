import Foundation

enum StoryGenerationError: Error {
    case missingAPIKey
    case networkError(Error)
    case invalidResponse
    case truncated
}

struct ClaudeStoryGenerator {
    private static let proxyURL = URL(string: "\(APIConfig.proxyBaseURL)/api/story")!

    static func generateStory(inputs: StoryInputs) async throws -> (title: String, text: String) {
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
            "system": [
                [
                    "type": "text",
                    "text": systemPrompt,
                    "cache_control": ["type": "ephemeral"]
                ]
            ],
            "messages": [
                ["role": "user", "content": userMessage]
            ]
        ]

        var request = URLRequest(url: proxyURL)
        request.httpMethod = "POST"
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
