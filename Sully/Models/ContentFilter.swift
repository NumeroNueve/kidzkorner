import Foundation

enum ContentFilter {
    private static let blocklist: Set<String> = [
        "ass", "asses", "asshole", "bastard", "bitch", "bitches",
        "blowjob", "boner", "boob", "boobs", "bullshit", "butt",
        "cock", "cocks", "crap", "cum", "cunt", "damn", "dammit",
        "dick", "dicks", "dildo", "douche", "dumbass",
        "fag", "fags", "fuck", "fucked", "fucker", "fucking", "fucks",
        "goddamn", "handjob", "hell", "ho", "hoe", "horny",
        "jackass", "jerk", "kill", "killed", "killing",
        "lesbian", "lmao", "milf",
        "nazi", "nigga", "nigger", "nipple", "nude", "nudes",
        "penis", "piss", "pissed", "porn", "porno", "prostitute", "pussy",
        "rape", "raped", "rapist", "retard", "retarded",
        "sex", "sexy", "shit", "shits", "shitty", "slut", "sluts",
        "stfu", "stupid", "suck", "sucks",
        "tit", "tits", "twat",
        "vagina", "viagra", "violence", "violent",
        "whore", "wtf",
        "blood", "bloody", "dead", "death", "die", "dies", "dying",
        "drug", "drugs", "drunk", "gore", "gun", "guns",
        "hate", "murder", "shoot", "shooting", "stab", "suicide",
        "weapon", "weapons", "zombie", "zombies",
    ]

    static func containsInappropriate(_ text: String) -> Bool {
        let words = text.lowercased()
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .filter { !$0.isEmpty }
        return words.contains { blocklist.contains($0) }
    }

    static func sanitize(_ text: String) -> String {
        var result = text
        let words = text.lowercased()
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .filter { !$0.isEmpty }
        for word in words where blocklist.contains(word) {
            if let range = result.range(of: word, options: .caseInsensitive) {
                result.replaceSubrange(range, with: "friend")
            }
        }
        return result
    }

    static func sanitizeInputs(_ inputs: StoryInputs) -> StoryInputs {
        var clean = inputs
        clean.heroName = sanitize(inputs.heroName)
        clean.animal = sanitize(inputs.animal)
        clean.place = sanitize(inputs.place)
        clean.food = sanitize(inputs.food)
        clean.color = sanitize(inputs.color)
        clean.sillySound = sanitize(inputs.sillySound)
        return clean
    }
}
