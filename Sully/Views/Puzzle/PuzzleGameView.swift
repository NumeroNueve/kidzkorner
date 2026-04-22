import SwiftUI

struct PuzzleGameView: View {
    let puzzleImage: PuzzleImage
    let gridSize: Int
    let pieceShape: PieceShape
    @State private var pieces: [PuzzlePiece] = []
    @State private var selectedPieceID: UUID?
    @State private var showCelebration = false
    @State private var referenceImage: UIImage?

    var body: some View {
        ZStack {
            Color.oceanBlue.ignoresSafeArea()

            GeometryReader { geo in
                let isLandscape = geo.size.width > geo.size.height
                let layout = puzzleLayout(in: geo.size, landscape: isLandscape)

                if isLandscape {
                    HStack(spacing: layout.spacing) {
                        VStack(spacing: layout.spacing) {
                            referencePreview(size: layout.refSize)
                            pieceBank(pieceSize: layout.bankPieceSize, isHorizontal: false, bankHeight: layout.boardSize)
                        }
                        .frame(width: layout.sideWidth)

                        puzzleBoard(pieceSize: layout.pieceSize, boardSize: layout.boardSize)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(layout.spacing)
                } else {
                    VStack(spacing: layout.spacing) {
                        referencePreview(size: layout.refSize)
                        puzzleBoard(pieceSize: layout.pieceSize, boardSize: layout.boardSize)
                        pieceBank(pieceSize: layout.bankPieceSize, isHorizontal: true, bankHeight: layout.bankPieceSize + 20)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(layout.spacing)
                }
            }

            if showCelebration {
                CelebrationView {
                    showCelebration = false
                    buildPuzzle()
                }
            }
        }
        .toolbarBackground(Color.oceanBlue, for: .navigationBar)
        .navigationTitle(puzzleImage.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { buildPuzzle() }
    }

    private func puzzleLayout(in size: CGSize, landscape: Bool) -> PuzzleLayout {
        let spacing: CGFloat = 16

        if landscape {
            let availableHeight = size.height - spacing * 2
            let pieceSize = availableHeight / CGFloat(gridSize)
            let boardSize = pieceSize * CGFloat(gridSize)
            let sideWidth = size.width - boardSize - spacing * 3
            let refSize = min(sideWidth, availableHeight * 0.35)
            let bankPieceSize = min(sideWidth * 0.4, pieceSize * 0.8)
            return PuzzleLayout(pieceSize: pieceSize, boardSize: boardSize, refSize: refSize, bankPieceSize: bankPieceSize, spacing: spacing, sideWidth: sideWidth)
        } else {
            let refHeight: CGFloat = size.height * 0.1
            let bankHeight: CGFloat = size.height * 0.12
            let availableHeight = size.height - refHeight - bankHeight - spacing * 5
            let availableWidth = size.width - spacing * 2
            let maxPieceSize = min(availableHeight, availableWidth) / CGFloat(gridSize)
            let pieceSize = maxPieceSize
            let boardSize = pieceSize * CGFloat(gridSize)
            let bankPieceSize = min(bankHeight - 20, pieceSize * 0.8)
            return PuzzleLayout(pieceSize: pieceSize, boardSize: boardSize, refSize: refHeight, bankPieceSize: bankPieceSize, spacing: spacing, sideWidth: 0)
        }
    }

    private func referencePreview(size: CGFloat) -> some View {
        Group {
            if let img = referenceImage {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFit()
                    .frame(height: size)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.white.opacity(0.5), lineWidth: 1)
                    )
            }
        }
    }

    private func puzzleBoard(pieceSize: CGFloat, boardSize: CGFloat) -> some View {
        ZStack {
            LazyVGrid(
                columns: Array(repeating: GridItem(.fixed(pieceSize), spacing: 0), count: gridSize),
                spacing: 0
            ) {
                ForEach(0..<(gridSize * gridSize), id: \.self) { i in
                    let row = i / gridSize
                    let col = i % gridSize
                    let isOccupied = pieces.contains { $0.correctRow == row && $0.correctCol == col && $0.isPlaced }

                    Rectangle()
                        .fill(isOccupied ? .clear : .white.opacity(0.15))
                        .frame(width: pieceSize, height: pieceSize)
                        .border(.white.opacity(0.3), width: 0.5)
                        .onTapGesture {
                            handleBoardTap(row: row, col: col)
                        }
                }
            }
            .frame(width: boardSize, height: boardSize)

            ForEach(pieces.filter(\.isPlaced)) { piece in
                let x = CGFloat(piece.correctCol) * pieceSize + pieceSize / 2
                let y = CGFloat(piece.correctRow) * pieceSize + pieceSize / 2
                Image(uiImage: piece.image)
                    .resizable()
                    .frame(width: pieceSize, height: pieceSize)
                    .position(x: x, y: y)
                    .allowsHitTesting(false)
            }
        }
        .frame(width: boardSize, height: boardSize)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.white.opacity(0.5), lineWidth: 2)
        )
    }

    private func pieceBank(pieceSize bankPieceSize: CGFloat, isHorizontal: Bool, bankHeight: CGFloat) -> some View {
        Group {
            if isHorizontal {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        pieceBankContent(bankPieceSize: bankPieceSize)
                    }
                    .padding(.horizontal)
                }
                .frame(height: bankPieceSize + 20)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: bankPieceSize), spacing: 8)], spacing: 8) {
                        pieceBankContent(bankPieceSize: bankPieceSize)
                    }
                    .padding(8)
                }
                .frame(maxHeight: bankHeight)
            }
        }
    }

    @ViewBuilder
    private func pieceBankContent(bankPieceSize: CGFloat) -> some View {
        ForEach(pieces.filter { !$0.isPlaced }) { piece in
            Image(uiImage: piece.image)
                .resizable()
                .frame(width: bankPieceSize, height: bankPieceSize)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(selectedPieceID == piece.id ? .yellow : .clear, lineWidth: 4)
                )
                .shadow(radius: selectedPieceID == piece.id ? 6 : 2)
                .scaleEffect(selectedPieceID == piece.id ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 0.2), value: selectedPieceID)
                .onTapGesture {
                    withAnimation {
                        selectedPieceID = (selectedPieceID == piece.id) ? nil : piece.id
                    }
                }
        }
    }

    private func handleBoardTap(row: Int, col: Int) {
        guard let selectedID = selectedPieceID,
              let index = pieces.firstIndex(where: { $0.id == selectedID }) else { return }

        if pieces[index].correctRow == row && pieces[index].correctCol == col {
            withAnimation(.spring(duration: 0.3)) {
                pieces[index].isPlaced = true
                selectedPieceID = nil
            }

            if pieces.allSatisfy(\.isPlaced) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation { showCelebration = true }
                }
            }
        } else {
            withAnimation(.easeInOut(duration: 0.15)) {
                selectedPieceID = nil
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.easeInOut(duration: 0.15)) {
                    selectedPieceID = pieces[index].id
                }
            }
        }
    }

    private func buildPuzzle() {
        selectedPieceID = nil
        let source: UIImage
        if let loaded = puzzleImage.loadImage() {
            source = loaded
        } else {
            source = generatePlaceholderImage(for: puzzleImage.name)
        }

        referenceImage = source

        let size = min(source.size.width, source.size.height)
        let origin = CGPoint(
            x: (source.size.width - size) / 2,
            y: (source.size.height - size) / 2
        )
        let cropRect = CGRect(origin: origin, size: CGSize(width: size, height: size))

        guard let cgImage = source.cgImage?.cropping(to: cropRect) else { return }
        let squareImage = UIImage(cgImage: cgImage)

        let tileSize = CGFloat(cgImage.width) / CGFloat(gridSize)
        var newPieces: [PuzzlePiece] = []

        for row in 0..<gridSize {
            for col in 0..<gridSize {
                let tileRect = CGRect(
                    x: CGFloat(col) * tileSize,
                    y: CGFloat(row) * tileSize,
                    width: tileSize,
                    height: tileSize
                )
                if let tileCG = squareImage.cgImage?.cropping(to: tileRect) {
                    let tileImage: UIImage
                    if pieceShape == .jigsaw {
                        tileImage = applyJigsawMask(
                            to: UIImage(cgImage: tileCG),
                            row: row, col: col,
                            gridSize: gridSize
                        )
                    } else {
                        tileImage = UIImage(cgImage: tileCG)
                    }
                    newPieces.append(PuzzlePiece(
                        correctRow: row,
                        correctCol: col,
                        image: tileImage,
                        currentPosition: .zero
                    ))
                }
            }
        }

        pieces = newPieces.shuffled()
    }

    private func applyJigsawMask(to image: UIImage, row: Int, col: Int, gridSize: Int) -> UIImage {
        let size = image.size
        let tabSize: CGFloat = size.width * 0.18
        let expandedSize = CGSize(width: size.width + tabSize * 2, height: size.height + tabSize * 2)

        let renderer = UIGraphicsImageRenderer(size: expandedSize)
        return renderer.image { ctx in
            let context = ctx.cgContext
            let center = CGRect(x: tabSize, y: tabSize, width: size.width, height: size.height)

            let path = UIBezierPath()
            let tabRadius = tabSize * 0.5

            // Top edge
            path.move(to: CGPoint(x: center.minX, y: center.minY))
            if row > 0 {
                let mid = center.minX + size.width / 2
                path.addLine(to: CGPoint(x: mid - tabRadius, y: center.minY))
                path.addArc(
                    withCenter: CGPoint(x: mid, y: center.minY),
                    radius: tabRadius,
                    startAngle: .pi, endAngle: 0, clockwise: (row + col) % 2 == 0
                )
                path.addLine(to: CGPoint(x: center.maxX, y: center.minY))
            } else {
                path.addLine(to: CGPoint(x: center.maxX, y: center.minY))
            }

            // Right edge
            if col < gridSize - 1 {
                let mid = center.minY + size.height / 2
                path.addLine(to: CGPoint(x: center.maxX, y: mid - tabRadius))
                path.addArc(
                    withCenter: CGPoint(x: center.maxX, y: mid),
                    radius: tabRadius,
                    startAngle: -.pi / 2, endAngle: .pi / 2, clockwise: (row + col) % 2 == 0
                )
                path.addLine(to: CGPoint(x: center.maxX, y: center.maxY))
            } else {
                path.addLine(to: CGPoint(x: center.maxX, y: center.maxY))
            }

            // Bottom edge
            if row < gridSize - 1 {
                let mid = center.minX + size.width / 2
                path.addLine(to: CGPoint(x: mid + tabRadius, y: center.maxY))
                path.addArc(
                    withCenter: CGPoint(x: mid, y: center.maxY),
                    radius: tabRadius,
                    startAngle: 0, endAngle: .pi, clockwise: (row + col) % 2 == 0
                )
                path.addLine(to: CGPoint(x: center.minX, y: center.maxY))
            } else {
                path.addLine(to: CGPoint(x: center.minX, y: center.maxY))
            }

            // Left edge
            if col > 0 {
                let mid = center.minY + size.height / 2
                path.addLine(to: CGPoint(x: center.minX, y: mid + tabRadius))
                path.addArc(
                    withCenter: CGPoint(x: center.minX, y: mid),
                    radius: tabRadius,
                    startAngle: .pi / 2, endAngle: -.pi / 2, clockwise: (row + col) % 2 == 0
                )
                path.addLine(to: CGPoint(x: center.minX, y: center.minY))
            } else {
                path.addLine(to: CGPoint(x: center.minX, y: center.minY))
            }

            path.close()

            context.addPath(path.cgPath)
            context.clip()

            image.draw(in: center)
        }
    }

    private func generatePlaceholderImage(for name: String) -> UIImage {
        let size = CGSize(width: 600, height: 600)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { ctx in
            let colors: [UIColor] = [.systemBlue, .systemPurple, .systemOrange, .systemGreen, .systemPink]
            for i in 0..<5 {
                let color = colors[i % colors.count]
                color.setFill()
                let rect = CGRect(
                    x: CGFloat.random(in: 0...400),
                    y: CGFloat.random(in: 0...400),
                    width: CGFloat.random(in: 100...300),
                    height: CGFloat.random(in: 100...300)
                )
                ctx.fill(rect)
            }

            let emoji: String = switch name.lowercased() {
            case "star": "⭐️"
            case "heart": "❤️"
            case "truck": "🚛"
            default: "🧩"
            }
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 200)
            ]
            let string = NSAttributedString(string: emoji, attributes: attrs)
            let strSize = string.size()
            let point = CGPoint(x: (size.width - strSize.width) / 2, y: (size.height - strSize.height) / 2)
            string.draw(at: point)
        }
    }
}

private struct PuzzleLayout {
    let pieceSize: CGFloat
    let boardSize: CGFloat
    let refSize: CGFloat
    let bankPieceSize: CGFloat
    let spacing: CGFloat
    let sideWidth: CGFloat
}
