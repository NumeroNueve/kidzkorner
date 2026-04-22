import SwiftUI

struct DrawingLibraryView: View {
    @ObservedObject var store: DrawingStore

    private let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 16)
    ]

    var body: some View {
        Group {
            if store.drawings.isEmpty {
                VStack(spacing: 16) {
                    Text("🎨")
                        .font(.system(size: 60))
                    Text("No drawings yet!")
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(store.drawings) { drawing in
                            NavigationLink {
                                DrawingDetailView(drawing: drawing, store: store)
                            } label: {
                                drawingThumbnail(drawing)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .background(Color.oceanBlue.ignoresSafeArea())
        .navigationTitle("My Drawings")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func drawingThumbnail(_ drawing: SavedDrawing) -> some View {
        VStack(spacing: 4) {
            Group {
                if let image = store.imageFor(drawing) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    Rectangle().fill(.gray.opacity(0.2))
                }
            }
            .frame(height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 2)

            Text(drawing.date, format: .dateTime.month().day().hour().minute())
                .font(.system(size: 12, design: .rounded))
                .foregroundStyle(.secondary)
        }
    }
}

struct DrawingDetailView: View {
    let drawing: SavedDrawing
    @ObservedObject var store: DrawingStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            if let image = store.imageFor(drawing) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding()
            }

            Spacer()

            Button(role: .destructive) {
                store.delete(drawing)
                dismiss()
            } label: {
                Label("Delete Drawing", systemImage: "trash")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(.red.gradient, in: Capsule())
            }
            .padding(.bottom)
        }
        .background(Color.oceanBlue.ignoresSafeArea())
        .navigationTitle(drawing.date.formatted(.dateTime.month().day()))
        .navigationBarTitleDisplayMode(.inline)
    }
}
