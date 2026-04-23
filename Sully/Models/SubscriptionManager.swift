import StoreKit

@Observable
final class SubscriptionManager {
    static let shared = SubscriptionManager()

    enum Tier: String, CaseIterable {
        case free
        case storyteller  // $4.99/mo — 20 voiced stories
        case unlimited    // $9.99/mo — 60 voiced stories
    }

    static let storytellerProductID = "com.wolfe.kidzkorner.storyteller"
    static let unlimitedProductID = "com.wolfe.kidzkorner.unlimited"

    private(set) var tier: Tier = .free
    private(set) var products: [Product] = []
    private var updateTask: Task<Void, Never>?

    private let freeVoicedLimit = 3
    private let storytellerVoicedLimit = 20
    private let unlimitedVoicedLimit = 60

    @ObservationIgnored
    private let defaults = UserDefaults.standard

    var voicedStoriesUsed: Int {
        let key = monthKey()
        return defaults.integer(forKey: key)
    }

    var voicedStoriesRemaining: Int {
        max(0, voicedStoriesLimit - voicedStoriesUsed)
    }

    var voicedStoriesLimit: Int {
        switch tier {
        case .free: return freeVoicedLimit
        case .storyteller: return storytellerVoicedLimit
        case .unlimited: return unlimitedVoicedLimit
        }
    }

    var canUseVoicedStory: Bool {
        voicedStoriesRemaining > 0
    }

    private init() {
        updateTask = Task { [weak self] in
            guard let self else { return }
            for await result in Transaction.updates {
                if case .verified(let transaction) = result {
                    await transaction.finish()
                    await self.refreshTier()
                }
            }
        }
        Task { await loadProducts() }
        Task { await refreshTier() }
    }

    deinit {
        updateTask?.cancel()
    }

    func recordVoicedStory() {
        let key = monthKey()
        let current = defaults.integer(forKey: key)
        defaults.set(current + 1, forKey: key)
    }

    func loadProducts() async {
        do {
            let ids = [Self.storytellerProductID, Self.unlimitedProductID]
            products = try await Product.products(for: ids)
                .sorted { $0.price < $1.price }
        } catch {
            products = []
        }
    }

    func purchase(_ product: Product) async throws -> Bool {
        let result = try await product.purchase()
        switch result {
        case .success(let verification):
            if case .verified(let transaction) = verification {
                await transaction.finish()
                await refreshTier()
                return true
            }
            return false
        case .userCancelled, .pending:
            return false
        @unknown default:
            return false
        }
    }

    func restorePurchases() async {
        try? await AppStore.sync()
        await refreshTier()
    }

    @MainActor
    func refreshTier() async {
        var newTier: Tier = .free
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result {
                switch transaction.productID {
                case Self.unlimitedProductID:
                    newTier = .unlimited
                case Self.storytellerProductID:
                    if newTier != .unlimited { newTier = .storyteller }
                default:
                    break
                }
            }
        }
        tier = newTier
    }

    private func monthKey() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return "voicedStories_\(formatter.string(from: Date()))"
    }
}
