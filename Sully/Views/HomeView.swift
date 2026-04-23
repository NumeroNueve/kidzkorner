import SwiftUI

struct HomeView: View {
    @State private var showSettings = false
    @AppStorage("playerName") private var playerName = ""
    @State private var showNamePrompt = false
    @State private var nameInput = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Image("wallpaper")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Spacer()

                    Text(playerName.isEmpty ? "My Games" : "\(playerName)'s Games")
                        .font(.system(size: 42, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.5), radius: 4, y: 2)

                    VStack(spacing: 16) {
                        NavigationLink {
                            MatchingDeckPickerView()
                        } label: {
                            GameButton(
                                title: "Matching",
                                icon: "rectangle.on.rectangle",
                                colors: [Color(red: 0.0, green: 0.45, blue: 0.75),
                                         Color(red: 0.0, green: 0.6, blue: 0.85)]
                            )
                        }

                        NavigationLink {
                            PuzzlePickerView()
                        } label: {
                            GameButton(
                                title: "Puzzles",
                                icon: "puzzlepiece.fill",
                                colors: [Color(red: 0.0, green: 0.65, blue: 0.55),
                                         Color(red: 0.15, green: 0.8, blue: 0.65)]
                            )
                        }

                        NavigationLink {
                            DrawingCanvasView()
                        } label: {
                            GameButton(
                                title: "Drawing",
                                icon: "paintbrush.fill",
                                colors: [Color(red: 0.7, green: 0.2, blue: 0.6),
                                         Color(red: 0.85, green: 0.35, blue: 0.65)]
                            )
                        }

                        NavigationLink {
                            StorySetupView()
                        } label: {
                            GameButton(
                                title: "Storytime",
                                icon: "book.fill",
                                colors: [Color(red: 0.3, green: 0.15, blue: 0.5),
                                         Color(red: 0.5, green: 0.25, blue: 0.65)]
                            )
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal, 40)
                .padding(.vertical)

                VStack {
                    HStack {
                        Spacer()
                        Button {
                            showSettings = true
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 24))
                                .foregroundStyle(.white.opacity(0.8))
                                .padding(12)
                                .background(.ultraThinMaterial, in: Circle())
                        }
                    }
                    Spacer()
                }
                .padding(.top, 8)
                .padding(.trailing, 16)
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
            .alert("What's your name?", isPresented: $showNamePrompt) {
                TextField("Your name", text: $nameInput)
                Button("Let's Play!") {
                    let trimmed = nameInput.trimmingCharacters(in: .whitespaces)
                    if !trimmed.isEmpty {
                        playerName = trimmed
                    }
                }
            } message: {
                Text("We'll personalize your games!")
            }
            .onAppear {
                if playerName.isEmpty {
                    nameInput = ""
                    showNamePrompt = true
                }
            }
        }
    }
}

struct GameButton: View {
    let title: String
    let icon: String
    let colors: [Color]
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    var body: some View {
        let isCompact = verticalSizeClass == .compact
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: isCompact ? 24 : 36))
            Text(title)
                .font(.system(size: isCompact ? 22 : 28, weight: .bold, design: .rounded))
        }
        .foregroundStyle(.white)
        .shadow(color: .black.opacity(0.3), radius: 2, y: 1)
        .frame(maxWidth: 600)
        .frame(height: isCompact ? 60 : 100)
        .background(
            LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing),
            in: RoundedRectangle(cornerRadius: isCompact ? 16 : 24)
        )
        .shadow(color: .black.opacity(0.3), radius: 6, y: 3)
    }
}
