import SwiftUI

struct MatchingSetupView: View {
    let deck: MatchingDeck
    @State private var pairCount: Int = 3

    private var maxPairs: Int { deck.pairs.count }
    private var minPairs: Int { 3 }

    var body: some View {
        VStack(spacing: 32) {
            Text(deck.icon)
                .font(.system(size: 80))

            Text("How many pairs?")
                .font(.system(size: 28, weight: .bold, design: .rounded))

            HStack(spacing: 24) {
                Button {
                    if pairCount > minPairs { pairCount -= 1 }
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(pairCount > minPairs ? .white : .white.opacity(0.3))
                        .shadow(radius: 4)
                }
                .disabled(pairCount <= minPairs)

                VStack(spacing: 4) {
                    Text("\(pairCount)")
                        .font(.system(size: 64, weight: .bold, design: .rounded))
                        .contentTransition(.numericText())
                        .animation(.snappy, value: pairCount)

                    Text("\(pairCount * 2) cards")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundStyle(.secondary)
                }
                .frame(width: 120)

                Button {
                    if pairCount < maxPairs { pairCount += 1 }
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(pairCount < maxPairs ? .white : .white.opacity(0.3))
                        .shadow(radius: 4)
                }
                .disabled(pairCount >= maxPairs)
            }

            NavigationLink {
                MatchingGameView(deck: deck, pairCount: pairCount)
            } label: {
                Text("Play!")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(.green.gradient, in: Capsule())
                    .padding(.horizontal, 40)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.oceanBlue)
        .toolbarBackground(Color.oceanBlue, for: .navigationBar)
        .navigationTitle(deck.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            pairCount = min(maxPairs, 5)
        }
    }
}
