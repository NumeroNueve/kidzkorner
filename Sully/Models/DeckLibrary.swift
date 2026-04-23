import Foundation

enum DeckLibrary {
    static let seaCreaturesDeck = MatchingDeck(
        name: "Sea Creatures",
        icon: "🦈",
        thumbnailImage: "sea_shark",
        pairs: [
            .init(pairID: "shark", imageName: "sea_shark", emoji: nil, label: "Shark"),
            .init(pairID: "turtle", imageName: "sea_turtle", emoji: nil, label: "Turtle"),
            .init(pairID: "octopus", imageName: "sea_octopus", emoji: nil, label: "Octopus"),
            .init(pairID: "seahorse", imageName: "sea_seahorse", emoji: nil, label: "Seahorse"),
            .init(pairID: "dolphin", imageName: "sea_dolphin", emoji: nil, label: "Dolphin"),
            .init(pairID: "crab", imageName: "sea_crab", emoji: nil, label: "Crab"),
            .init(pairID: "whaleshark", imageName: "sea_whaleshark", emoji: nil, label: "Whale Shark"),
            .init(pairID: "lobster", imageName: "sea_lobster", emoji: nil, label: "Lobster"),
            .init(pairID: "barracuda", imageName: "sea_barracuda", emoji: nil, label: "Barracuda"),
            .init(pairID: "squid", imageName: "sea_squid", emoji: nil, label: "Squid"),
        ]
    )

    static let monsterTrucksDeck = MatchingDeck(
        name: "Monster Trucks",
        icon: "🛻",
        thumbnailImage: "mt_bluflame",
        pairs: [
            .init(pairID: "blueflame", imageName: "mt_bluflame", emoji: nil, label: "Blue Flame"),
            .init(pairID: "swamp", imageName: "mt_swamp", emoji: nil, label: "Swamp Crusher"),
            .init(pairID: "desert", imageName: "mt_desert", emoji: nil, label: "Desert Storm"),
            .init(pairID: "ice", imageName: "mt_ice", emoji: nil, label: "Ice Breaker"),
            .init(pairID: "jungle", imageName: "mt_jungle", emoji: nil, label: "Jungle Rumble"),
            .init(pairID: "beach", imageName: "mt_beach", emoji: nil, label: "Beach Cruiser"),
            .init(pairID: "moon", imageName: "mt_moon", emoji: nil, label: "Moon Rider"),
            .init(pairID: "dino", imageName: "mt_dino", emoji: nil, label: "Dino Smasher"),
            .init(pairID: "firetruck", imageName: "mt_firetruck", emoji: nil, label: "Fire Rescue"),
            .init(pairID: "candy", imageName: "mt_candy", emoji: nil, label: "Candy Crusher"),
        ]
    )

    static let dinosaursDeck = MatchingDeck(
        name: "Dinosaurs",
        icon: "🦕",
        thumbnailImage: "dino_trex",
        pairs: [
            .init(pairID: "triceratops", imageName: "dino_triceratops", emoji: nil, label: "Triceratops"),
            .init(pairID: "brachiosaurus", imageName: "dino_brachiosaurus", emoji: nil, label: "Brachiosaurus"),
            .init(pairID: "trex", imageName: "dino_trex", emoji: nil, label: "T-Rex"),
            .init(pairID: "pterodactyl", imageName: "dino_pterodactyl", emoji: nil, label: "Pterodactyl"),
            .init(pairID: "ankylosaurus", imageName: "dino_ankylosaurus", emoji: nil, label: "Ankylosaurus"),
            .init(pairID: "velociraptor", imageName: "dino_velociraptor", emoji: nil, label: "Velociraptor"),
            .init(pairID: "parasaurolophus", imageName: "dino_parasaurolophus", emoji: nil, label: "Parasaurolophus"),
            .init(pairID: "spinosaurus", imageName: "dino_spinosaurus", emoji: nil, label: "Spinosaurus"),
            .init(pairID: "raptors", imageName: "dino_raptors", emoji: nil, label: "Raptors"),
        ]
    )

    static let jungleAnimalsDeck = MatchingDeck(
        name: "Jungle Animals",
        icon: "🌴",
        thumbnailImage: "jungle_toucan",
        pairs: [
            .init(pairID: "toucan", imageName: "jungle_toucan", emoji: nil, label: "Toucan"),
            .init(pairID: "gorilla", imageName: "jungle_gorilla", emoji: nil, label: "Gorilla"),
            .init(pairID: "sloth", imageName: "jungle_sloth", emoji: nil, label: "Sloth"),
            .init(pairID: "jaguar", imageName: "jungle_jaguar", emoji: nil, label: "Jaguar"),
            .init(pairID: "parrot", imageName: "jungle_parrot", emoji: nil, label: "Parrot"),
            .init(pairID: "treefrog", imageName: "jungle_treefrog", emoji: nil, label: "Tree Frog"),
            .init(pairID: "capybara", imageName: "jungle_capybara", emoji: nil, label: "Capybara"),
            .init(pairID: "anaconda", imageName: "jungle_anaconda", emoji: nil, label: "Anaconda"),
            .init(pairID: "monkey", imageName: "jungle_monkey", emoji: nil, label: "Monkey"),
        ]
    )

    static let puzzleImages: [PuzzleImage] = [
        PuzzleImage(name: "Pirate Adventure", imageName: "puzzle_pirate"),
        PuzzleImage(name: "Race Car", imageName: "puzzle_racecar"),
        PuzzleImage(name: "Orca", imageName: "puzzle_orca"),
        PuzzleImage(name: "Firefighter", imageName: "puzzle_firefighter"),
        PuzzleImage(name: "Loon Lake", imageName: "puzzle_loon"),
    ]
}
