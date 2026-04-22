import Foundation

enum DeckLibrary {
    static let familyDeck = MatchingDeck(
        name: "Family",
        icon: "👨‍👩‍👦",
        thumbnailImage: "family_photo",
        pairs: [
            .init(pairID: "adam", imageName: "family_adam", emoji: nil, label: "Adam"),
            .init(pairID: "alex", imageName: "family_alex", emoji: nil, label: "Alex"),
            .init(pairID: "caelan", imageName: "family_caelan", emoji: nil, label: "Caelan"),
            .init(pairID: "craig", imageName: "family_craig", emoji: nil, label: "Ye Ye"),
            .init(pairID: "emily", imageName: "family_emily", emoji: nil, label: "Emily"),
            .init(pairID: "finn", imageName: "family_finn", emoji: nil, label: "Finn"),
            .init(pairID: "leslie", imageName: "family_leslie", emoji: nil, label: "Leslie"),
            .init(pairID: "lori", imageName: "family_lori", emoji: nil, label: "Nai Nai"),
            .init(pairID: "mallory", imageName: "family_mallory", emoji: nil, label: "Mallory"),
            .init(pairID: "megan", imageName: "family_megan", emoji: nil, label: "Megan"),
            .init(pairID: "retta", imageName: "family_retta", emoji: nil, label: "Gigi"),
            .init(pairID: "simmy", imageName: "family_simmy", emoji: nil, label: "Simmy"),
            .init(pairID: "sully", imageName: "family_sully", emoji: nil, label: "Sully"),
            .init(pairID: "taylor", imageName: "family_taylor", emoji: nil, label: "Dada"),
            .init(pairID: "mama", imageName: "family_mama", emoji: nil, label: "Mama"),
            .init(pairID: "kelly", imageName: "family_kelly", emoji: nil, label: "Kelly"),
            .init(pairID: "peter", imageName: "family_peter", emoji: nil, label: "Peter"),
            .init(pairID: "betty", imageName: "family_betty", emoji: nil, label: "Betty"),
            .init(pairID: "danny", imageName: "family_danny", emoji: nil, label: "Danny"),
            .init(pairID: "george", imageName: "family_george", emoji: nil, label: "George"),
            .init(pairID: "heidi", imageName: "family_heidi", emoji: nil, label: "Heidi"),
            .init(pairID: "james", imageName: "family_james", emoji: nil, label: "James"),
            .init(pairID: "molly", imageName: "family_molly", emoji: nil, label: "Momo"),
            .init(pairID: "penny", imageName: "family_penny", emoji: nil, label: "Penny"),
            .init(pairID: "rami", imageName: "family_rami", emoji: nil, label: "Rami"),
        ]
    )

    static let seaCreaturesDeck = MatchingDeck(
        name: "Sea Creatures",
        icon: "🦈",
        thumbnailImage: nil,
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
        thumbnailImage: nil,
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
        PuzzleImage(name: "Lightning McQueen", imageName: "puzzle_lightning"),
        PuzzleImage(name: "Whale Shark", imageName: "puzzle_whaleshark"),
        PuzzleImage(name: "Frozen", imageName: "puzzle_frozen"),
        PuzzleImage(name: "Grave Digger", imageName: "puzzle_gravedigger"),
        PuzzleImage(name: "Megalodon", imageName: "puzzle_megalodon"),
        PuzzleImage(name: "Great White Shark", imageName: "puzzle_greatwhite"),
        PuzzleImage(name: "Hammerhead Shark", imageName: "puzzle_hammerhead"),
        PuzzleImage(name: "T-Rex", imageName: "puzzle_trex"),
        PuzzleImage(name: "Dinosaurs", imageName: "puzzle_dinosaurs"),
    ]
}
