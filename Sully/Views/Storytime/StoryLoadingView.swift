import SwiftUI

struct StoryLoadingView: View {
    @State private var pulse = false

    var body: some View {
        ZStack {
            Image("story_loading")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.3))

            VStack(spacing: 20) {
                Text("📖")
                    .font(.system(size: 80))
                    .scaleEffect(pulse ? 1.1 : 0.9)
                    .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: pulse)

                Text("Writing your story...")
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.5), radius: 4, y: 2)
            }
        }
        .onAppear { pulse = true }
    }
}
