import SwiftUI
import AVFoundation
import PhotosUI

struct EmojiChoice: Identifiable {
    let id = UUID()
    let label: String
    let emoji: String
}

struct ColorChoice: Identifiable {
    let id = UUID()
    let label: String
    let color: Color
}

struct SoundChoice: Identifiable {
    let id = UUID()
    let label: String
}

private let animalChoices: [EmojiChoice] = [
    EmojiChoice(label: "Dog", emoji: "🐕"),
    EmojiChoice(label: "Cat", emoji: "🐱"),
    EmojiChoice(label: "Dragon", emoji: "🐉"),
    EmojiChoice(label: "Dinosaur", emoji: "🦕"),
    EmojiChoice(label: "Bear", emoji: "🐻"),
    EmojiChoice(label: "Bunny", emoji: "🐰"),
]

private let placeChoices: [EmojiChoice] = [
    EmojiChoice(label: "The Beach", emoji: "🏖️"),
    EmojiChoice(label: "The Moon", emoji: "🌙"),
    EmojiChoice(label: "A Castle", emoji: "🏰"),
    EmojiChoice(label: "The Jungle", emoji: "🌴"),
    EmojiChoice(label: "The Park", emoji: "🎡"),
]

private let foodChoices: [EmojiChoice] = [
    EmojiChoice(label: "Pizza", emoji: "🍕"),
    EmojiChoice(label: "Tacos", emoji: "🌮"),
    EmojiChoice(label: "Ice Cream", emoji: "🍦"),
    EmojiChoice(label: "Cookies", emoji: "🍪"),
    EmojiChoice(label: "Pancakes", emoji: "🥞"),
]

private let colorChoices: [ColorChoice] = [
    ColorChoice(label: "Red", color: .red),
    ColorChoice(label: "Blue", color: .blue),
    ColorChoice(label: "Green", color: .green),
    ColorChoice(label: "Purple", color: .purple),
    ColorChoice(label: "Gold", color: Color(red: 0.85, green: 0.7, blue: 0.1)),
    ColorChoice(label: "Pink", color: .pink),
]

private let soundChoices: [SoundChoice] = [
    SoundChoice(label: "Boing!"),
    SoundChoice(label: "Splat!"),
    SoundChoice(label: "Whoosh!"),
    SoundChoice(label: "Kaboom!"),
    SoundChoice(label: "Zip-zap!"),
]

private let spokenQuestions: [String] = [
    "Who is the hero of our story?",
    "What animal friend should join the adventure?",
    "Where should the adventure take place?",
    "What yummy food should be in the story?",
    "What's your favorite color?",
    "Pick a silly sound!",
]

private let cardEmojis = ["🦸", "🐾", "📍", "🍕", "🎨", "🔊"]
private let cardLabels = ["Hero Name", "Animal Friend", "Fun Place", "Yummy Food", "Favorite Color", "Silly Sound"]

struct StorySetupView: View {
    @State private var inputs = StoryInputs()
    @State private var currentIndex = 0
    @State private var navigateToPlayback = false
    @State private var promptSpeaker = AVSpeechSynthesizer()
    @State private var customAnimal = ""
    @State private var customPlace = ""
    @State private var customFood = ""
    @State private var customColor = ""
    @State private var customSound = ""

    private var characterStore = UserCharacterStore.shared
    @State private var showingAddCharacter = false
    @State private var newCharacterName = ""
    @State private var selectedCharacterPhoto: PhotosPickerItem?
    @State private var pendingCharacterImage: UIImage?

    private var allFilled: Bool {
        !inputs.heroName.isEmpty && !inputs.animal.isEmpty &&
        !inputs.place.isEmpty && !inputs.food.isEmpty &&
        !inputs.color.isEmpty && !inputs.sillySound.isEmpty
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.2, green: 0.1, blue: 0.4), Color(red: 0.4, green: 0.15, blue: 0.5)],
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                progressDots

                TabView(selection: $currentIndex) {
                    heroCard.tag(0)
                    animalCard.tag(1)
                    placeCard.tag(2)
                    foodCard.tag(3)
                    colorCard.tag(4)
                    soundCard.tag(5)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentIndex)

                bottomButtons
            }
            .padding(.vertical)

            .navigationDestination(isPresented: $navigateToPlayback) {
                StoryPlaybackView(inputs: inputs)
            }
        }
        .navigationTitle("Storytime")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color(red: 0.2, green: 0.1, blue: 0.4), for: .navigationBar)
        .onAppear {
            speakQuestion(at: 0)
        }
        .onChange(of: currentIndex) { _, newIndex in
            speakQuestion(at: newIndex)
        }
        .onDisappear {
            promptSpeaker.stopSpeaking(at: .immediate)
        }
    }

    private func speakQuestion(at index: Int) {
        promptSpeaker.stopSpeaking(at: .immediate)
        let utterance = AVSpeechUtterance(string: spokenQuestions[index])
        utterance.voice = VoiceHelper.preferredVoice
        utterance.rate = 0.45
        utterance.pitchMultiplier = 1.15
        utterance.preUtteranceDelay = 0.4
        promptSpeaker.speak(utterance)
    }

    private func speakSound(_ text: String) {
        promptSpeaker.stopSpeaking(at: .immediate)
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = VoiceHelper.preferredVoice
        utterance.rate = 0.4
        utterance.pitchMultiplier = 1.3
        promptSpeaker.speak(utterance)
    }

    // MARK: - Progress

    private var progressDots: some View {
        HStack(spacing: 10) {
            ForEach(0..<6, id: \.self) { i in
                let filled = isStepFilled(i)
                Circle()
                    .fill(filled ? .green : .white.opacity(0.3))
                    .frame(width: 14, height: 14)
                    .scaleEffect(i == currentIndex ? 1.3 : 1.0)
                    .animation(.spring(duration: 0.3), value: currentIndex)
            }
        }
        .padding(.top, 8)
    }

    private func isStepFilled(_ index: Int) -> Bool {
        switch index {
        case 0: return !inputs.heroName.isEmpty
        case 1: return !inputs.animal.isEmpty
        case 2: return !inputs.place.isEmpty
        case 3: return !inputs.food.isEmpty
        case 4: return !inputs.color.isEmpty
        case 5: return !inputs.sillySound.isEmpty
        default: return false
        }
    }

    // MARK: - Card header

    private func cardHeader(index: Int) -> some View {
        VStack(spacing: 12) {
            Text(cardEmojis[index])
                .font(.system(size: 70))
            Text(cardLabels[index])
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
        }
    }

    // MARK: - Hero card

    private var heroCard: some View {
        VStack(spacing: 20) {
            cardHeader(index: 0)

            if characterStore.characters.isEmpty {
                VStack(spacing: 16) {
                    Text("Add your first character!")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white.opacity(0.8))

                    addCharacterButton
                }
                .padding(.horizontal, 24)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(characterStore.characters) { character in
                            Button {
                                inputs.heroName = character.name
                            } label: {
                                characterBubble(character)
                            }
                            .contextMenu {
                                Button(role: .destructive) {
                                    if inputs.heroName == character.name {
                                        inputs.heroName = ""
                                    }
                                    characterStore.deleteCharacter(id: character.id)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }

                        addCharacterButton
                    }
                    .padding(.horizontal, 24)
                }
            }
        }
        .padding()
        .onChange(of: selectedCharacterPhoto) { _, newValue in
            guard let item = newValue else { return }
            Task {
                if let data = try? await item.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    pendingCharacterImage = image
                }
                selectedCharacterPhoto = nil
                newCharacterName = ""
                showingAddCharacter = true
            }
        }
        .alert("Name Your Character", isPresented: $showingAddCharacter) {
            TextField("Character name", text: $newCharacterName)
            Button("Add") {
                let name = newCharacterName.trimmingCharacters(in: .whitespaces)
                guard !name.isEmpty else { return }
                characterStore.addCharacter(name: name, image: pendingCharacterImage)
                inputs.heroName = name
                pendingCharacterImage = nil
            }
            Button("Cancel", role: .cancel) {
                pendingCharacterImage = nil
            }
        }
    }

    private func characterBubble(_ character: SavedCharacter) -> some View {
        let isSelected = inputs.heroName == character.name
        return VStack(spacing: 8) {
            Group {
                if let filename = character.imageFilename,
                   let uiImage = characterStore.loadImage(filename: filename) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                } else {
                    Text(String(character.name.prefix(1)).uppercased())
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.purple.opacity(0.5))
                }
            }
            .frame(width: 70, height: 70)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(isSelected ? Color.green : Color.white.opacity(0.3),
                            lineWidth: isSelected ? 4 : 2)
            )
            .shadow(color: isSelected ? .green.opacity(0.6) : .clear, radius: 8)

            Text(character.name)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(isSelected ? .green : .white)
        }
    }

    private var addCharacterButton: some View {
        PhotosPicker(selection: $selectedCharacterPhoto, matching: .images) {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.15))
                        .frame(width: 70, height: 70)
                    Image(systemName: "plus")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white.opacity(0.8))
                }
                Text("Add")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(.white.opacity(0.6))
            }
        }
    }

    // MARK: - Emoji grid cards (animal, place, food)

    private var animalCard: some View {
        emojiGridCard(index: 1, choices: animalChoices, value: inputs.animal, customText: $customAnimal) {
            inputs.animal = $0
        }
    }

    private var placeCard: some View {
        emojiGridCard(index: 2, choices: placeChoices, value: inputs.place, customText: $customPlace) {
            inputs.place = $0
        }
    }

    private var foodCard: some View {
        emojiGridCard(index: 3, choices: foodChoices, value: inputs.food, customText: $customFood) {
            inputs.food = $0
        }
    }

    private func emojiGridCard(index: Int, choices: [EmojiChoice], value: String, customText: Binding<String>, onSelect: @escaping (String) -> Void) -> some View {
        VStack(spacing: 20) {
            cardHeader(index: index)

            let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(choices) { choice in
                    Button {
                        customText.wrappedValue = ""
                        onSelect(choice.label)
                    } label: {
                        VStack(spacing: 6) {
                            Text(choice.emoji)
                                .font(.system(size: 36))
                            Text(choice.label)
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(
                            value == choice.label && customText.wrappedValue.isEmpty ? Color.green : Color.white.opacity(0.15),
                            in: RoundedRectangle(cornerRadius: 16)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(value == choice.label && customText.wrappedValue.isEmpty ? Color.green : Color.clear, lineWidth: 3)
                        )
                    }
                }
            }
            .padding(.horizontal, 24)

            customInputField(text: customText, placeholder: cardLabels[index], onCommit: onSelect)
        }
        .padding()
    }

    private func customInputField(text: Binding<String>, placeholder: String, onCommit: @escaping (String) -> Void) -> some View {
        HStack(spacing: 8) {
            Image(systemName: "pencil")
                .foregroundStyle(.white.opacity(0.6))
            TextField("Or type your own...", text: text)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(.white)
                .onChange(of: text.wrappedValue) { _, newValue in
                    let trimmed = newValue.trimmingCharacters(in: .whitespaces)
                    if !trimmed.isEmpty {
                        onCommit(trimmed)
                    }
                }
        }
        .padding(12)
        .background(Color.white.opacity(0.12), in: RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 24)
    }

    // MARK: - Color card

    private var colorCard: some View {
        VStack(spacing: 20) {
            cardHeader(index: 4)

            let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(colorChoices) { choice in
                    Button {
                        customColor = ""
                        inputs.color = choice.label
                    } label: {
                        Text(choice.label)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                choice.color.gradient,
                                in: RoundedRectangle(cornerRadius: 16)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(inputs.color == choice.label && customColor.isEmpty ? Color.white : Color.clear, lineWidth: 4)
                            )
                            .shadow(color: inputs.color == choice.label && customColor.isEmpty ? choice.color.opacity(0.7) : .clear,
                                    radius: 10)
                    }
                }
            }
            .padding(.horizontal, 24)

            customInputField(text: $customColor, placeholder: "Favorite Color") {
                inputs.color = $0
            }
        }
        .padding()
    }

    // MARK: - Sound card

    private var soundCard: some View {
        VStack(spacing: 20) {
            cardHeader(index: 5)

            let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 2)
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(soundChoices) { choice in
                    Button {
                        customSound = ""
                        inputs.sillySound = choice.label
                        speakSound(choice.label)
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "speaker.wave.2.fill")
                                .font(.system(size: 18))
                            Text(choice.label)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            inputs.sillySound == choice.label && customSound.isEmpty ? Color.green : Color.white.opacity(0.15),
                            in: RoundedRectangle(cornerRadius: 16)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(inputs.sillySound == choice.label && customSound.isEmpty ? Color.green : Color.clear, lineWidth: 3)
                        )
                    }
                }
            }
            .padding(.horizontal, 24)

            customInputField(text: $customSound, placeholder: "Silly Sound") {
                inputs.sillySound = $0
            }
        }
        .padding()
    }

    // MARK: - Bottom buttons

    private var bottomButtons: some View {
        HStack(spacing: 20) {
            if currentIndex > 0 {
                Button {
                    withAnimation { currentIndex -= 1 }
                } label: {
                    Image(systemName: "arrow.left.circle.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(.white.opacity(0.7))
                }
            }

            Spacer()

            if currentIndex < 5 {
                Button {
                    withAnimation { currentIndex += 1 }
                } label: {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(.white.opacity(0.9))
                }
            } else if allFilled {
                Button {
                    promptSpeaker.stopSpeaking(at: .immediate)
                    navigateToPlayback = true
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "book.fill")
                        Text("Make My Story!")
                    }
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
                    .background(.green.gradient, in: Capsule())
                    .shadow(color: .green.opacity(0.5), radius: 8, y: 4)
                }
            }
        }
        .padding(.horizontal, 30)
        .frame(height: 60)
    }
}
