import SwiftUI

struct CelebrationView: View {
    let onPlayAgain: () -> Void
    @State private var stars: [(id: Int, x: CGFloat, y: CGFloat, emoji: String)] = []

    private let celebrationEmojis = ["⭐️", "🎉", "🥳", "🏆", "👏", "💪", "🌟", "🎊"]

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Text("🏆")
                    .font(.system(size: 80))

                Text("You Win!")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundStyle(.yellow)

                Button(action: onPlayAgain) {
                    Text("Play Again!")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 16)
                        .background(.green.gradient, in: Capsule())
                }
            }

            ForEach(stars, id: \.id) { star in
                Text(star.emoji)
                    .font(.system(size: 30))
                    .position(x: star.x, y: star.y)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .onAppear { animateStars() }
    }

    private func animateStars() {
        for i in 0..<20 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.15) {
                let star = (
                    id: i,
                    x: CGFloat.random(in: 30...350),
                    y: CGFloat.random(in: 50...700),
                    emoji: celebrationEmojis.randomElement()!
                )
                withAnimation(.easeOut(duration: 0.4)) {
                    stars.append(star)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.easeIn(duration: 0.3)) {
                        stars.removeAll { $0.id == i }
                    }
                }
            }
        }
    }
}
