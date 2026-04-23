import SwiftUI

struct StoryLibraryView: View {
    private var store = StoryStore.shared

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.1, green: 0.1, blue: 0.3), Color(red: 0.2, green: 0.05, blue: 0.35)],
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea()

            if store.stories.isEmpty {
                VStack(spacing: 16) {
                    Text("No saved stories yet!")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                    Text("Create a story and tap the heart to save it here.")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(store.stories) { story in
                            NavigationLink {
                                StoryPlaybackView(savedStory: story)
                            } label: {
                                StoryRow(story: story)
                            }
                            .contextMenu {
                                Button(role: .destructive) {
                                    store.deleteStory(id: story.id)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .padding(16)
                }
            }
        }
        .navigationTitle("My Stories")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color(red: 0.1, green: 0.1, blue: 0.3), for: .navigationBar)
    }
}

private struct StoryRow: View {
    let story: SavedStory

    var body: some View {
        HStack(spacing: 16) {
            Text("📖")
                .font(.system(size: 36))

            VStack(alignment: .leading, spacing: 4) {
                Text(story.title)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .lineLimit(1)

                Text("Starring \(story.inputs.heroName)")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(.white.opacity(0.7))

                Text(story.savedAt, style: .date)
                    .font(.system(size: 13, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
            }

            Spacer()

            if story.audioFilename != nil {
                Image(systemName: "speaker.wave.2.fill")
                    .font(.system(size: 16))
                    .foregroundStyle(.white.opacity(0.5))
            }

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.white.opacity(0.4))
        }
        .padding(16)
        .background(.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 16))
    }
}
