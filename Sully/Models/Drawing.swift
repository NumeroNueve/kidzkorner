import UIKit

struct DrawingLine {
    var points: [CGPoint] = []
    var color: UIColor = .black
    var lineWidth: CGFloat = 5.0
}

struct SavedDrawing: Identifiable, Codable {
    let id: UUID
    let date: Date
    let filename: String

    init(id: UUID = UUID(), date: Date = Date(), filename: String) {
        self.id = id
        self.date = date
        self.filename = filename
    }
}

class DrawingStore: ObservableObject {
    @Published var drawings: [SavedDrawing] = []

    private let fileManager = FileManager.default

    private var directoryURL: URL {
        let docs = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let dir = docs.appendingPathComponent("SullyDrawings")
        if !fileManager.fileExists(atPath: dir.path) {
            try? fileManager.createDirectory(at: dir, withIntermediateDirectories: true)
        }
        return dir
    }

    private var manifestURL: URL {
        directoryURL.appendingPathComponent("manifest.json")
    }

    init() {
        load()
    }

    func save(image: UIImage) {
        let drawing = SavedDrawing(filename: "\(UUID().uuidString).png")
        let url = directoryURL.appendingPathComponent(drawing.filename)
        if let data = image.pngData() {
            try? data.write(to: url)
            drawings.insert(drawing, at: 0)
            persist()
        }
    }

    func delete(_ drawing: SavedDrawing) {
        let url = directoryURL.appendingPathComponent(drawing.filename)
        try? fileManager.removeItem(at: url)
        drawings.removeAll { $0.id == drawing.id }
        persist()
    }

    func imageFor(_ drawing: SavedDrawing) -> UIImage? {
        let url = directoryURL.appendingPathComponent(drawing.filename)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }

    private func persist() {
        if let data = try? JSONEncoder().encode(drawings) {
            try? data.write(to: manifestURL)
        }
    }

    private func load() {
        guard let data = try? Data(contentsOf: manifestURL),
              let saved = try? JSONDecoder().decode([SavedDrawing].self, from: data) else { return }
        drawings = saved
    }
}
