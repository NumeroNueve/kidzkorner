import SwiftUI

struct MatchingCard: Identifiable {
    let id = UUID()
    let pairID: String
    let imageName: String?
    let emoji: String?
    let label: String
    var isFaceUp = false
    var isMatched = false
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
    }

    func buildCards(count: Int? = nil) -> (cards: [MatchingCard], pairCount: Int) {
        let selectedPairs: [CardPair]
        if let count = count, count < pairs.count {
            selectedPairs = Array(pairs.shuffled().prefix(count))
        } else {
            selectedPairs = pairs
        }

        var cards: [MatchingCard] = []
        for pair in selectedPairs {
            cards.append(MatchingCard(pairID: pair.pairID, imageName: pair.imageName, emoji: pair.emoji, label: pair.label))
            cards.append(MatchingCard(pairID: pair.pairID, imageName: pair.imageName, emoji: pair.emoji, label: pair.label))
        }
        return (cards.shuffled(), selectedPairs.count)
    }
}
