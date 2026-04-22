import SwiftUI

struct CardView: View {
    let card: MatchingCard

    var body: some View {
        GeometryReader { geo in
            ZStack {
                if card.isFaceUp || card.isMatched {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                        .shadow(radius: 2)

                    VStack(spacing: 2) {
                        if let imageName = card.imageName {
                            Image(imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width - 12, height: geo.size.height * 0.7)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .padding(.top, 6)
                                .padding(.horizontal, 6)
                        } else if let emoji = card.emoji {
                            Text(emoji)
                                .font(.system(size: min(geo.size.height * 0.5, 50)))
                                .frame(height: geo.size.height * 0.7)
                        }

                        Text(card.label)
                            .font(.system(size: min(geo.size.width * 0.15, 18), weight: .bold, design: .rounded))
                            .foregroundStyle(.primary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .padding(.horizontal, 4)
                            .padding(.bottom, 4)
                    }
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(red: 0.55, green: 0.85, blue: 0.97))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 0.15, green: 0.35, blue: 0.55), lineWidth: 2)
                        )
                        .shadow(radius: 2)

                    Image("card_back")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .aspectRatio(1 / 1.3, contentMode: .fit)
        .opacity(card.isMatched ? 0.6 : 1.0)
        .scaleEffect(card.isMatched ? 0.95 : 1.0)
        .rotation3DEffect(
            .degrees(card.isFaceUp || card.isMatched ? 0 : 180),
            axis: (x: 0, y: 1, z: 0)
        )
    }
}
