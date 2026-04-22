import SwiftUI

struct MatchingGameView: View {
    let deck: MatchingDeck
    let pairCount: Int
    @State private var cards: [MatchingCard] = []
    @State private var activePairCount = 0
    @State private var firstFlippedIndex: Int?
    @State private var isProcessing = false
    @State private var matchedCount = 0
    @State private var showCelebration = false

    var body: some View {
        ZStack {
            Color.oceanBlue.ignoresSafeArea()

            GeometryReader { geo in
                let layout = gridLayout(for: cards.count, in: geo.size)

                ScrollView {
                    LazyVGrid(
                        columns: Array(repeating: GridItem(.fixed(layout.cardWidth), spacing: layout.spacing), count: layout.columns),
                        spacing: layout.spacing
                    ) {
                        ForEach(Array(cards.enumerated()), id: \.element.id) { index, card in
                            CardView(card: card)
                                .frame(height: layout.cardHeight)
                                .onTapGesture { cardTapped(at: index) }
                        }
                    }
                    .padding(layout.spacing)
                }
            }

            if showCelebration {
                CelebrationView {
                    showCelebration = false
                    startGame()
                }
            }
        }
        .toolbarBackground(Color.oceanBlue, for: .navigationBar)
        .navigationTitle(deck.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { startGame() }
    }

    private func gridLayout(for cardCount: Int, in size: CGSize) -> GridLayout {
        guard cardCount > 0 else {
            return GridLayout(columns: 2, cardWidth: 100, cardHeight: 150, spacing: 12)
        }

        let bestColumns: Int
        let totalCards = cardCount

        if size.width > 700 {
            // iPad
            if totalCards <= 8 { bestColumns = 4 }
            else if totalCards <= 12 { bestColumns = 4 }
            else if totalCards <= 20 { bestColumns = 5 }
            else { bestColumns = 6 }
        } else {
            // iPhone
            if totalCards <= 8 { bestColumns = 2 }
            else if totalCards <= 12 { bestColumns = 3 }
            else if totalCards <= 20 { bestColumns = 4 }
            else { bestColumns = 4 }
        }

        let spacing: CGFloat = size.width > 700 ? 16 : 12
        let totalSpacing = spacing * CGFloat(bestColumns + 1)
        let cardWidth = (size.width - totalSpacing) / CGFloat(bestColumns)
        let cardHeight = cardWidth * 1.3

        let rows = ceil(Double(totalCards) / Double(bestColumns))
        let totalHeight = CGFloat(rows) * cardHeight + CGFloat(rows + 1) * spacing

        if totalHeight <= size.height {
            return GridLayout(columns: bestColumns, cardWidth: cardWidth, cardHeight: cardHeight, spacing: spacing)
        }

        let availableHeight = size.height - spacing * (CGFloat(rows) + 1)
        let fittedCardHeight = availableHeight / CGFloat(rows)
        let fittedCardWidth = fittedCardHeight / 1.3

        return GridLayout(columns: bestColumns, cardWidth: fittedCardWidth, cardHeight: fittedCardHeight, spacing: spacing)
    }

    private func cardTapped(at index: Int) {
        guard !isProcessing,
              !cards[index].isFaceUp,
              !cards[index].isMatched else { return }

        withAnimation(.easeInOut(duration: 0.3)) {
            cards[index].isFaceUp = true
        }

        if let firstIndex = firstFlippedIndex {
            isProcessing = true
            firstFlippedIndex = nil

            let isMatch = cards[firstIndex].pairID == cards[index].pairID

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    if isMatch {
                        cards[firstIndex].isMatched = true
                        cards[index].isMatched = true
                        matchedCount += 1

                        if matchedCount == activePairCount {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation { showCelebration = true }
                            }
                        }
                    } else {
                        cards[firstIndex].isFaceUp = false
                        cards[index].isFaceUp = false
                    }
                }
                isProcessing = false
            }
        } else {
            firstFlippedIndex = index
        }
    }

    private func startGame() {
        matchedCount = 0
        firstFlippedIndex = nil
        let result = deck.buildCards(count: pairCount)
        cards = result.cards
        activePairCount = result.pairCount
    }
}

private struct GridLayout {
    let columns: Int
    let cardWidth: CGFloat
    let cardHeight: CGFloat
    let spacing: CGFloat
}
