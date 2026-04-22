import UIKit

@Observable
final class UserDeckStore {
    static let shared = UserDeckStore()

    private(set) var decks: [SavedDeckEntry] = []

    private let directory: URL = {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let dir = docs.appendingPathComponent("UserDecks", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir
    }()

    private let manifestURL: URL

    private init() {
        manifestURL = directory.appendingPathComponent("manifest.json")
        load()
    }

    func addDeck(name: String, icon: String, pairs: [(label: String, image: UIImage)]) {
        var savedPairs: [SavedPairEntry] = []
        for pair in pairs {
            let id = UUID().uuidString
            let filename = "\(id).jpg"
            let fileURL = directory.appendingPathComponent(filename)
            if let data = pair.image.jpegData(compressionQuality: 0.85) {
                try? data.write(to: fileURL)
            }
            savedPairs.append(SavedPairEntry(pairID: id, label: pair.label, imageFilename: filename))
        }

        let entry = SavedDeckEntry(id: UUID().uuidString, name: name, icon: icon, pairs: savedPairs)
        decks.append(entry)
        save()
    }

    func deleteDeck(id: String) {
        guard let index = decks.firstIndex(where: { $0.id == id }) else { return }
        let deck = decks[index]
        for pair in deck.pairs {
            try? FileManager.default.removeItem(at: directory.appendingPathComponent(pair.imageFilename))
        }
        decks.remove(at: index)
        save()
    }

    func loadImage(filename: String) -> UIImage? {
        let url = directory.appendingPathComponent(filename)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }

    func toMatchingDeck(_ entry: SavedDeckEntry) -> MatchingDeck {
        let pairs = entry.pairs.map { savedPair in
            MatchingDeck.CardPair(
                pairID: savedPair.pairID,
                imageName: nil,
                emoji: nil,
                label: savedPair.label,
                userImage: loadImage(filename: savedPair.imageFilename)
            )
        }
        return MatchingDeck(name: entry.name, icon: entry.icon, thumbnailImage: nil, pairs: pairs)
    }

    private func save() {
        if let data = try? JSONEncoder().encode(decks) {
            try? data.write(to: manifestURL)
        }
    }

    private func load() {
        guard let data = try? Data(contentsOf: manifestURL),
              let entries = try? JSONDecoder().decode([SavedDeckEntry].self, from: data) else { return }
        decks = entries
    }
}

struct SavedDeckEntry: Codable, Identifiable {
    let id: String
    let name: String
    let icon: String
    let pairs: [SavedPairEntry]
}

struct SavedPairEntry: Codable {
    let pairID: String
    let label: String
    let imageFilename: String
}
