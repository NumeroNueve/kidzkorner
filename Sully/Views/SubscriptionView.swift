import SwiftUI
import StoreKit

struct SubscriptionView: View {
    @Environment(\.dismiss) private var dismiss
    private var sub = SubscriptionManager.shared
    @State private var purchasing = false
    @State private var errorMessage: String?

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.15, green: 0.1, blue: 0.35), Color(red: 0.3, green: 0.1, blue: 0.45)],
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    header
                    tierComparison
                    productCards
                    restoreButton
                    legalLinks

                    if let errorMessage {
                        Text(errorMessage)
                            .font(.system(size: 14, design: .rounded))
                            .foregroundStyle(.red)
                            .padding(.horizontal, 24)
                    }
                }
                .padding(.vertical, 24)
            }
        }
        .overlay(alignment: .topTrailing) {
            Button { dismiss() } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.white.opacity(0.6))
                    .padding(16)
            }
        }
    }

    private var header: some View {
        VStack(spacing: 12) {
            Text("Unlock Premium Voices")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            Text("Stories come alive with a professional narrator voice! Free stories always include Apple's built-in voice.")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            HStack(spacing: 6) {
                Image(systemName: "speaker.wave.2.fill")
                    .foregroundStyle(.yellow)
                Text("\(sub.voicedStoriesRemaining) voiced stories remaining this month")
                    .foregroundStyle(.white.opacity(0.7))
            }
            .font(.system(size: 14, weight: .medium, design: .rounded))
        }
    }

    private var tierComparison: some View {
        VStack(spacing: 12) {
            tierRow(name: "Free", detail: "3 voiced stories/month", active: sub.tier == .free)
            tierRow(name: "Storyteller", detail: "20 voiced stories/month", active: sub.tier == .storyteller)
            tierRow(name: "Unlimited", detail: "60 voiced stories/month", active: sub.tier == .unlimited)
        }
        .padding(.horizontal, 24)
    }

    private func tierRow(name: String, detail: String, active: Bool) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                Text(detail)
                    .font(.system(size: 14, design: .rounded))
                    .foregroundStyle(.white.opacity(0.7))
            }
            Spacer()
            if active {
                Text("Current")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundStyle(.green)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(.green.opacity(0.2), in: Capsule())
            }
        }
        .padding(16)
        .background(
            active ? Color.white.opacity(0.12) : Color.white.opacity(0.06),
            in: RoundedRectangle(cornerRadius: 14)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(active ? Color.green.opacity(0.5) : Color.clear, lineWidth: 2)
        )
    }

    private var productCards: some View {
        VStack(spacing: 12) {
            ForEach(sub.products, id: \.id) { product in
                let isCurrentTier = (product.id == SubscriptionManager.storytellerProductID && sub.tier == .storyteller)
                    || (product.id == SubscriptionManager.unlimitedProductID && sub.tier == .unlimited)

                Button {
                    guard !purchasing, !isCurrentTier else { return }
                    purchasing = true
                    errorMessage = nil
                    Task {
                        do {
                            _ = try await sub.purchase(product)
                        } catch {
                            errorMessage = "Purchase failed. Please try again."
                        }
                        purchasing = false
                    }
                } label: {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(product.displayName)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                            Text(product.description)
                                .font(.system(size: 14, design: .rounded))
                                .foregroundStyle(.white.opacity(0.7))
                        }
                        Spacer()
                        Text(product.displayPrice + "/mo")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundStyle(isCurrentTier ? .green : .yellow)
                    }
                    .padding(16)
                    .background(Color.white.opacity(0.1), in: RoundedRectangle(cornerRadius: 16))
                }
                .disabled(purchasing || isCurrentTier)
                .opacity(purchasing ? 0.6 : 1.0)
            }
        }
        .padding(.horizontal, 24)
    }

    private var restoreButton: some View {
        Button {
            Task { await sub.restorePurchases() }
        } label: {
            Text("Restore Purchases")
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundStyle(.white.opacity(0.6))
        }
    }

    private var legalLinks: some View {
        HStack(spacing: 20) {
            Link("Privacy Policy", destination: URL(string: "https://taylorwolfe30.github.io/kidzkorner/privacy.html")!)
            Link("Terms of Use", destination: URL(string: "https://taylorwolfe30.github.io/kidzkorner/terms.html")!)
        }
        .font(.system(size: 13, weight: .medium, design: .rounded))
        .foregroundStyle(.white.opacity(0.45))
    }
}
