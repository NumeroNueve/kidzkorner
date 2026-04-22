import SwiftUI
import PhotosUI

struct PuzzlePickerView: View {
    private let builtInImages = DeckLibrary.puzzleImages
    private var userStore = UserPuzzleStore.shared

    @State private var selectedPhoto: PhotosPickerItem?
    @State private var showingNamePrompt = false
    @State private var pendingImage: UIImage?
    @State private var newPuzzleName = ""

    private var allImages: [PuzzleImage] {
        builtInImages + userStore.puzzles
    }

    var body: some View {
        ZStack {
            Color.oceanBlue.ignoresSafeArea()

            GeometryReader { geo in
                let columns = geo.size.width > 700 ? 3 : 2
                let spacing: CGFloat = 20
                let totalSpacing = spacing * CGFloat(columns + 1)
                let tileWidth = (geo.size.width - totalSpacing) / CGFloat(columns)

                ScrollView {
                    VStack(spacing: 16) {
                        Text("Pick a Puzzle!")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .padding(.top)

                        LazyVGrid(
                            columns: Array(repeating: GridItem(.fixed(tileWidth), spacing: spacing), count: columns),
                            spacing: spacing
                        ) {
                            ForEach(allImages) { puzzleImage in
                                NavigationLink {
                                    PuzzleSetupView(puzzleImage: puzzleImage)
                                } label: {
                                    puzzleThumbnail(puzzleImage, width: tileWidth)
                                }
                                .contextMenu {
                                    if puzzleImage.userImageFilename != nil {
                                        Button(role: .destructive) {
                                            removeUserPuzzle(puzzleImage)
                                        } label: {
                                            Label("Delete Puzzle", systemImage: "trash")
                                        }
                                    }
                                }
                            }

                            addPuzzleButton(width: tileWidth)
                        }
                        .padding(.horizontal, spacing)
                    }
                }
            }
        }
        .toolbarBackground(Color.oceanBlue, for: .navigationBar)
        .navigationTitle("Puzzles")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectedPhoto) { _, newValue in
            guard let item = newValue else { return }
            Task {
                if let data = try? await item.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    pendingImage = image
                    newPuzzleName = ""
                    showingNamePrompt = true
                }
                selectedPhoto = nil
            }
        }
        .alert("Name Your Puzzle", isPresented: $showingNamePrompt) {
            TextField("Puzzle name", text: $newPuzzleName)
            Button("Add") {
                guard let image = pendingImage, !newPuzzleName.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                userStore.add(name: newPuzzleName.trimmingCharacters(in: .whitespaces), image: image)
                pendingImage = nil
            }
            Button("Cancel", role: .cancel) {
                pendingImage = nil
            }
        }
    }

    private func addPuzzleButton(width: CGFloat) -> some View {
        PhotosPicker(selection: $selectedPhoto, matching: .images) {
            VStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white.opacity(0.15))
                        .frame(width: width, height: width)

                    VStack(spacing: 12) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 44))
                            .foregroundStyle(.white.opacity(0.8))
                        Text("Add Photo")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundStyle(.white.opacity(0.8))
                    }
                }

                Text(" ")
                    .font(.system(size: min(width * 0.12, 22), weight: .semibold, design: .rounded))
            }
        }
    }

    private func puzzleThumbnail(_ puzzleImage: PuzzleImage, width: CGFloat) -> some View {
        VStack(spacing: 8) {
            Group {
                if let uiImage = puzzleImage.loadImage() {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                } else {
                    placeholderImage(for: puzzleImage.name)
                }
            }
            .frame(width: width, height: width)
            .clipShape(RoundedRectangle(cornerRadius: 20))

            Text(puzzleImage.name)
                .font(.system(size: min(width * 0.12, 22), weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
        }
    }

    private func placeholderImage(for name: String) -> some View {
        let emoji: String = switch name.lowercased() {
        case "star": "⭐️"
        case "heart": "❤️"
        case "truck": "🚛"
        default: "🧩"
        }
        return ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.blue.opacity(0.15))
            Text(emoji)
                .font(.system(size: 60))
        }
    }

    private func removeUserPuzzle(_ puzzle: PuzzleImage) {
        guard let index = userStore.puzzles.firstIndex(where: { $0.id == puzzle.id }) else { return }
        userStore.remove(at: IndexSet(integer: index))
    }
}
