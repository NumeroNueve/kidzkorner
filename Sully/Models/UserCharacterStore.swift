import UIKit

@Observable
final class UserCharacterStore {
    static let shared = UserCharacterStore()

    private(set) var characters: [SavedCharacter] = []

    private let directory: URL = {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let dir = docs.appendingPathComponent("UserCharacters", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir
    }()

    private let manifestURL: URL

    private init() {
        manifestURL = directory.appendingPathComponent("manifest.json")
        load()
    }

    func addCharacter(name: String, image: UIImage?) {
        var filename: String?
        if let image = image {
            let id = UUID().uuidString
            filename = "\(id).jpg"
            let fileURL = directory.appendingPathComponent(filename!)
            if let data = image.jpegData(compressionQuality: 0.85) {
                try? data.write(to: fileURL)
            }
        }

        let character = SavedCharacter(id: UUID().uuidString, name: name, imageFilename: filename)
        characters.append(character)
        save()
    }

    func deleteCharacter(id: String) {
        guard let index = characters.firstIndex(where: { $0.id == id }) else { return }
        let character = characters[index]
        if let filename = character.imageFilename {
            try? FileManager.default.removeItem(at: directory.appendingPathComponent(filename))
        }
        characters.remove(at: index)
        save()
    }

    func loadImage(filename: String) -> UIImage? {
        let url = directory.appendingPathComponent(filename)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }

    private func save() {
        if let data = try? JSONEncoder().encode(characters) {
            try? data.write(to: manifestURL)
        }
    }

    private func load() {
        guard let data = try? Data(contentsOf: manifestURL),
              let entries = try? JSONDecoder().decode([SavedCharacter].self, from: data) else { return }
        characters = entries
    }
}

struct SavedCharacter: Codable, Identifiable {
    let id: String
    let name: String
    let imageFilename: String?
}
