import Foundation

struct SavedStory: Codable, Identifiable {
    let id: String
    let title: String
    let text: String
    let inputs: StoryInputs
    let audioFilename: String?
    let savedAt: Date
}

@Observable
final class StoryStore {
    static let shared = StoryStore()

    private(set) var stories: [SavedStory] = []

    private let directory: URL = {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let dir = docs.appendingPathComponent("SavedStories", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir
    }()

    private let manifestURL: URL

    private init() {
        manifestURL = directory.appendingPathComponent("manifest.json")
        load()
    }

    func saveStory(title: String, text: String, inputs: StoryInputs, audioData: Data?) -> SavedStory {
        var audioFilename: String?
        if let audioData = audioData {
            let id = UUID().uuidString
            audioFilename = "\(id).mp3"
            let fileURL = directory.appendingPathComponent(audioFilename!)
            try? audioData.write(to: fileURL)
        }

        let story = SavedStory(
            id: UUID().uuidString,
            title: title,
            text: text,
            inputs: inputs,
            audioFilename: audioFilename,
            savedAt: Date()
        )
        stories.insert(story, at: 0)
        persist()
        return story
    }

    func deleteStory(id: String) {
        guard let index = stories.firstIndex(where: { $0.id == id }) else { return }
        let story = stories[index]
        if let filename = story.audioFilename {
            try? FileManager.default.removeItem(at: directory.appendingPathComponent(filename))
        }
        stories.remove(at: index)
        persist()
    }

    func loadAudio(filename: String) -> Data? {
        let url = directory.appendingPathComponent(filename)
        return try? Data(contentsOf: url)
    }

    private func persist() {
        if let data = try? JSONEncoder().encode(stories) {
            try? data.write(to: manifestURL)
        }
    }

    private func load() {
        guard let data = try? Data(contentsOf: manifestURL),
              let entries = try? JSONDecoder().decode([SavedStory].self, from: data) else { return }
        stories = entries
    }
}
