import SwiftUI

struct MatchingDeckPickerView: View {
    private let builtInDecks = [DeckLibrary.seaCreaturesDeck, DeckLibrary.monsterTrucksDeck, DeckLibrary.dinosaursDeck, DeckLibrary.jungleAnimalsDeck]
    private var userStore = UserDeckStore.shared

    private var allDecks: [MatchingDeck] {
        builtInDecks + userStore.decks.map { userStore.toMatchingDeck($0) }
    }

    var body: some View {
        ZStack {
            Color.oceanBlue.ignoresSafeArea()

            GeometryReader { geo in
                let columns = geo.size.width > 700 ? 3 : 2
                let spacing: CGFloat = 20
                let totalSpacing = spacing * CGFloat(columns + 1)
                let tileWidth = (geo.size.width - totalSpacing) / CGFloat(columns)
                let imageHeight = tileWidth * 0.65
                let tileHeight = imageHeight + 50

                ScrollView {
                    VStack(spacing: 16) {
                        Text("Pick a Game!")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .padding(.top)

                        LazyVGrid(
                            columns: Array(repeating: GridItem(.fixed(tileWidth), spacing: spacing), count: columns),
                            spacing: spacing
                        ) {
                            ForEach(allDecks) { deck in
                                deckTile(deck: deck, width: tileWidth, imageHeight: imageHeight, tileHeight: tileHeight)
                            }

                            createDeckTile(width: tileWidth, imageHeight: imageHeight, tileHeight: tileHeight)
                        }
                        .padding(.horizontal, spacing)
                    }
                }
            }
        }
        .toolbarBackground(Color.oceanBlue, for: .navigationBar)
        .navigationTitle("Matching")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func deckTile(deck: MatchingDeck, width: CGFloat, imageHeight: CGFloat, tileHeight: CGFloat) -> some View {
        NavigationLink {
            MatchingSetupView(deck: deck)
        } label: {
            VStack(spacing: 8) {
                if let thumb = deck.thumbnailImage {
                    Image(thumb)
                        .resizable()
                        .scaledToFill()
                        .frame(width: width - 20, height: imageHeight)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                } else {
                    Text(deck.icon)
                        .font(.system(size: min(imageHeight * 0.6, 80)))
                        .frame(height: imageHeight)
                }
                Text(deck.name)
                    .font(.system(size: min(width * 0.1, 28), weight: .semibold, design: .rounded))
            }
            .foregroundStyle(.primary)
            .frame(width: width, height: tileHeight)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24))
        }
        .contextMenu {
            if let entry = userStore.decks.first(where: { $0.name == deck.name }) {
                Button(role: .destructive) {
                    userStore.deleteDeck(id: entry.id)
                } label: {
                    Label("Delete Deck", systemImage: "trash")
                }
            }
        }
    }

    private func createDeckTile(width: CGFloat, imageHeight: CGFloat, tileHeight: CGFloat) -> some View {
        NavigationLink {
            DeckCreatorView()
        } label: {
            VStack(spacing: 8) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: min(imageHeight * 0.5, 60)))
                    .foregroundStyle(.white.opacity(0.8))
                    .frame(height: imageHeight)
                Text("Create Your Own")
                    .font(.system(size: min(width * 0.09, 22), weight: .semibold, design: .rounded))
            }
            .foregroundStyle(.white.opacity(0.8))
            .frame(width: width, height: tileHeight)
            .background(Color.white.opacity(0.15), in: RoundedRectangle(cornerRadius: 24))
        }
    }
}
