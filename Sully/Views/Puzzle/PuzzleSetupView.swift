import SwiftUI

enum PieceShape: String, CaseIterable {
    case square = "Square"
    case jigsaw = "Jigsaw"

    var icon: String {
        switch self {
        case .square: return "square.grid.3x3.fill"
        case .jigsaw: return "puzzlepiece.fill"
        }
    }
}

struct PuzzleSetupView: View {
    let puzzleImage: PuzzleImage
    @State private var gridSize = 3
    @State private var pieceShape: PieceShape = .square

    private let gridOptions = [2, 3, 4, 5]

    var body: some View {
        VStack(spacing: 32) {
            if let img = puzzleImage.loadImage() {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 140)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 4)
            }

            Text(puzzleImage.name)
                .font(.system(size: 28, weight: .bold, design: .rounded))

            VStack(spacing: 12) {
                Text("How many pieces?")
                    .font(.system(size: 22, weight: .bold, design: .rounded))

                HStack(spacing: 16) {
                    ForEach(gridOptions, id: \.self) { size in
                        Button {
                            gridSize = size
                        } label: {
                            VStack(spacing: 4) {
                                Text("\(size * size)")
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                Text("\(size)x\(size)")
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                    .foregroundStyle(.secondary)
                            }
                            .frame(width: 70, height: 70)
                            .background(
                                gridSize == size ? Color.green : Color.white.opacity(0.15),
                                in: RoundedRectangle(cornerRadius: 16)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(gridSize == size ? Color.green : Color.clear, lineWidth: 3)
                            )
                        }
                        .foregroundStyle(gridSize == size ? .white : .primary)
                    }
                }
            }

            VStack(spacing: 12) {
                Text("Piece shape")
                    .font(.system(size: 22, weight: .bold, design: .rounded))

                HStack(spacing: 20) {
                    ForEach(PieceShape.allCases, id: \.self) { shape in
                        Button {
                            pieceShape = shape
                        } label: {
                            VStack(spacing: 8) {
                                Image(systemName: shape.icon)
                                    .font(.system(size: 36))
                                Text(shape.rawValue)
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                            }
                            .frame(width: 110, height: 90)
                            .background(
                                pieceShape == shape ? Color.green : Color.white.opacity(0.15),
                                in: RoundedRectangle(cornerRadius: 16)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(pieceShape == shape ? Color.green : Color.clear, lineWidth: 3)
                            )
                        }
                        .foregroundStyle(pieceShape == shape ? .white : .primary)
                    }
                }
            }

            NavigationLink {
                PuzzleGameView(puzzleImage: puzzleImage, gridSize: gridSize, pieceShape: pieceShape)
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
        .navigationTitle(puzzleImage.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
