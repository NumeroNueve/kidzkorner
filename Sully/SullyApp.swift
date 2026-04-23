import SwiftUI

@main
struct SullyApp: App {
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                HomeView()

                if showSplash {
                    SplashView()
                        .transition(.opacity)
                        .zIndex(1)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        showSplash = false
                    }
                }
            }
        }
    }
}

struct SplashView: View {
    @State private var titleScale: CGFloat = 0.8
    @State private var titleOpacity: Double = 0.0

    var body: some View {
        ZStack {
            Image("wallpaper")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            Text("Kidz Korner")
                .font(.system(size: 46, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.5), radius: 6, y: 3)
                .scaleEffect(titleScale)
                .opacity(titleOpacity)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.6)) {
                titleScale = 1.0
                titleOpacity = 1.0
            }
        }
    }
}
