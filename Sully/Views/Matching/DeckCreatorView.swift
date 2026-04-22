import SwiftUI
import PhotosUI

struct DeckCreatorView: View {
    @Environment(\.dismiss) private var dismiss
    private var store = UserDeckStore.shared

    @State private var deckName = ""
    @State private var selectedIcon = "🐶"
    @State private var pairs: [(label: String, image: UIImage)] = []

    @State private var selectedPhoto: PhotosPickerItem?
    @State private var pendingImage: UIImage?
    @State private var showingNamePrompt = false
    @State private var newPairLabel = ""

    private let iconChoices = ["🐶", "🐱", "🦁", "🐸", "🌟", "🚗", "🎈", "🏠", "🎵", "🍎", "⚽️", "🦋"]

    private var canSave: Bool {
        !deckName.trimmingCharacters(in: .whitespaces).isEmpty && pairs.count >= 3
    }

    var body: some View {
        ZStack {
            Color.oceanBlue.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    nameSection
                    iconSection
                    pairsSection
                    addPairButton
                    saveButton
                }
                .padding()
            }
        }
        .navigationTitle("Create Deck")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.oceanBlue, for: .navigationBar)
        .onChange(of: selectedPhoto) { _, newValue in
            guard let item = newValue else { return }
            Task {
                if let data = try? await item.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    pendingImage = image
                    newPairLabel = ""
                    showingNamePrompt = true
                }
                selectedPhoto = nil
            }
        }
        .alert("Name This Card", isPresented: $showingNamePrompt) {
            TextField("Card name", text: $newPairLabel)
            Button("Add") {
                guard let image = pendingImage,
                      !newPairLabel.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                pairs.append((label: newPairLabel.trimmingCharacters(in: .whitespaces), image: image))
                pendingImage = nil
            }
            Button("Cancel", role: .cancel) {
                pendingImage = nil
            }
        }
    }

    private var nameSection: some View {
        VStack(spacing: 8) {
            Text("Deck Name")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            TextField("My Deck", text: $deckName)
                .font(.system(size: 24, weight: .semibold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
        }
    }

    private var iconSection: some View {
        VStack(spacing: 8) {
            Text("Pick an Icon")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 6), spacing: 8) {
                ForEach(iconChoices, id: \.self) { icon in
                    Button {
                        selectedIcon = icon
                    } label: {
                        Text(icon)
                            .font(.system(size: 32))
                            .frame(width: 50, height: 50)
                            .background(
                                selectedIcon == icon ? Color.green : Color.white.opacity(0.15),
                                in: RoundedRectangle(cornerRadius: 12)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(selectedIcon == icon ? Color.green : Color.clear, lineWidth: 3)
                            )
                    }
                }
            }
        }
    }

    private var pairsSection: some View {
        VStack(spacing: 8) {
            Text("Cards (\(pairs.count))")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            if pairs.count < 3 {
                Text("Add at least 3 cards to save")
                    .font(.system(size: 14, design: .rounded))
                    .foregroundStyle(.white.opacity(0.6))
            }

            ForEach(Array(pairs.enumerated()), id: \.offset) { index, pair in
                HStack(spacing: 12) {
                    Image(uiImage: pair.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                    Text(pair.label)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white)

                    Spacer()

                    Button {
                        pairs.remove(at: index)
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundStyle(.red.opacity(0.8))
                    }
                }
                .padding(10)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14))
            }
        }
    }

    private var addPairButton: some View {
        PhotosPicker(selection: $selectedPhoto, matching: .images) {
            HStack(spacing: 10) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 24))
                Text("Add Card")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.white.opacity(0.2), in: RoundedRectangle(cornerRadius: 16))
        }
    }

    private var saveButton: some View {
        Button {
            store.addDeck(name: deckName.trimmingCharacters(in: .whitespaces), icon: selectedIcon, pairs: pairs)
            dismiss()
        } label: {
            HStack(spacing: 10) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 24))
                Text("Save Deck")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(canSave ? Color.green.gradient : Color.gray.gradient, in: RoundedRectangle(cornerRadius: 20))
            .shadow(color: canSave ? .green.opacity(0.4) : .clear, radius: 8, y: 4)
        }
        .disabled(!canSave)
    }
}
