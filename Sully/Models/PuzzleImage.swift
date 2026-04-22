import UIKit

struct PuzzleImage: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let userImageFilename: String?

    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
        self.userImageFilename = nil
    }

    init(name: String, userImageFilename: String) {
        self.name = name
        self.imageName = ""
        self.userImageFilename = userImageFilename
    }

    func loadImage() -> UIImage? {
        if let filename = userImageFilename {
            return UserPuzzleStore.shared.loadImage(filename: filename)
        }
        return UIImage(named: imageName)
    }
}

struct PuzzlePiece: Identifiable {
    let id = UUID()
    let correctRow: Int
    let correctCol: Int
    let image: UIImage
    var currentPosition: CGPoint
    var isPlaced = false
}
