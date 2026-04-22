import UIKit

@Observable
final class UserPuzzleStore {
    static let shared = UserPuzzleStore()

    private(set) var puzzles: [PuzzleImage] = []

    private let directory: URL = {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let dir = docs.appendingPathComponent("UserPuzzles", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir
    }()

    private let manifestURL: URL

    private init() {
        manifestURL = directory.appendingPathComponent("manifest.json")
        load()
    }

    func add(name: String, image: UIImage) {
        let id = UUID().uuidString
        let filename = "\(id).jpg"
        let fileURL = directory.appendingPathComponent(filename)

        guard let data = image.jpegData(compressionQuality: 0.85) else { return }
        try? data.write(to: fileURL)

        let puzzle = PuzzleImage(name: name, userImageFilename: filename)
        puzzles.append(puzzle)
        save()
    }

    func remove(at offsets: IndexSet) {
        for index in offsets {
            let puzzle = puzzles[index]
            if let filename = puzzle.userImageFilename {
                try? FileManager.default.removeItem(at: directory.appendingPathComponent(filename))
            }
        }
        puzzles.remove(atOffsets: offsets)
        save()
    }

    func loadImage(filename: String) -> UIImage? {
        let url = directory.appendingPathComponent(filename)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }

    private func save() {
        let entries = puzzles.compactMap { puzzle -> SavedEntry? in
            guard let filename = puzzle.userImageFilename else { return nil }
            return SavedEntry(name: puzzle.name, filename: filename)
        }
        if let data = try? JSONEncoder().encode(entries) {
            try? data.write(to: manifestURL)
        }
    }

    private func load() {
        guard let data = try? Data(contentsOf: manifestURL),
              let entries = try? JSONDecoder().decode([SavedEntry].self, from: data) else { return }
        puzzles = entries.map { PuzzleImage(name: $0.name, userImageFilename: $0.filename) }
    }
}

private struct SavedEntry: Codable {
    let name: String
    let filename: String
}
