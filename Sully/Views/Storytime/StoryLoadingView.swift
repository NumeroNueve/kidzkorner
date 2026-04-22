import SwiftUI

struct StoryLoadingView: View {
    @State private var pulse = false

    var body: some View {
        VStack(spacing: 20) {
            Text("📖")
                .font(.system(size: 80))
                .scaleEffect(pulse ? 1.1 : 0.9)
                .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: pulse)

            Text("Writing your story...")
                .font(.system(size: 26, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
        }
        .onAppear { pulse = true }
    }
}
