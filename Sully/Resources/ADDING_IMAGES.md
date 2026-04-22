# Adding Your Own Images to Sully

## Family Matching Cards

1. Open `Assets.xcassets` in Xcode
2. Drag in a photo of each family member (e.g. "photo_dad", "photo_mom")
3. Open `Models/DeckLibrary.swift`
4. Change `.emoji("👨")` to `.image("photo_dad")` for each person
5. Update the name text (`.text("Dad")`) if needed

Example:
```swift
.init(pairID: "dad", front: .image("photo_dad"), back: .text("Dad")),
```

## Vehicle Matching Cards

1. Add vehicle photos to `Assets.xcassets` (e.g. "car_red", "moto_blue", "monster_bigfoot")
2. In `DeckLibrary.swift`, change `.emoji("🏎️")` to `.image("car_red")`
3. For vehicles, both cards show the same image — the child matches identical pairs

Example:
```swift
.init(pairID: "racecar1", front: .image("car_red"), back: .image("car_red")),
```

## Puzzle Images

1. Add full images to `Assets.xcassets` (e.g. "puzzle_dinosaur")
2. In `DeckLibrary.swift`, add to the `puzzleImages` array:
```swift
PuzzleImage(name: "Dinosaur", imageName: "puzzle_dinosaur"),
```
3. The game will automatically crop the image to a square and split it into a 3x3 grid

**Tip:** Square images (or close to square) work best for puzzles.
