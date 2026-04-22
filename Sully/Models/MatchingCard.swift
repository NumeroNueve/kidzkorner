import SwiftUI

struct MatchingCard: Identifiable {
    let id = UUID()
    let pairID: String
    let imageName: String?
    let emoji: String?
    let label: String
    let userImage: UIImage?
    var isFaceUp = false
    var isMatched = false

    init(pairID: String, imageName: String?, emoji: String?, label: String, userImage: UIImage? = nil) {
        self.pairID = pairID
        self.imageName = imageName
        self.emoji = emoji
        self.label = label
        self.userImage = userImage
    }
}

struct MatchingDeck: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let thumbnailImage: String?
    let pairs: [CardPair]

    struct CardPair {
        let pairID: String
        let imageName: String?
        let emoji: String?
        let label: String
        let userImage: UIImage?

        init(pairID: String, imageName: String?, emoji: String?, label: String, userImage: UIImage? = nil) {
            self.pairID = pairID
            self.imageName = imageName
            self.emoji = emoji
            self.label = label
            self.userImage = userImage
        }
    }

    func buildCards(count: Int? = nil) -> (cards: [MatchingCard], pairCount: Int) {
        let selectedPairs: [CardPair]
        if let count = count, count < pairs.count {
            selectedPairs = Array(pairs.shuffled().prefix(count))
        } else {
            selectedPairs = pairs.shuffled()
        }

        var cards: [MatchingCard] = []
        for pair in selectedPairs {
            cards.append(MatchingCard(pairID: pair.pairID, imageName: pair.imageName, emoji: pair.emoji, label: pair.label, userImage: pair.userImage))
            cards.append(MatchingCard(pairID: pair.pairID, imageName: pair.imageName, emoji: pair.emoji, label: pair.label, userImage: pair.userImage))
        }
        return (cards.shuffled(), selectedPairs.count)
    }
}
