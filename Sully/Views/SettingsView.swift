import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("playerName") private var playerName = ""
    @State private var editingName = ""
    @State private var showSubscription = false
    @State private var showParentalGate = false

    private var sub = SubscriptionManager.shared

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(sub.tier == .free ? "Free Plan" : sub.tier == .storyteller ? "Storyteller" : "Unlimited")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                            Text("\(sub.voicedStoriesRemaining) voiced stories remaining")
                                .font(.system(size: 14, design: .rounded))
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Button {
                            showParentalGate = true
                        } label: {
                            Text(sub.tier == .free ? "Upgrade" : "Manage")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(.purple.gradient, in: Capsule())
                        }
                    }
                } header: {
                    Text("Subscription")
                }

                Section {
                    TextField("Your name", text: $editingName)
                        .font(.system(size: 18, design: .rounded))
                        .onSubmit {
                            let trimmed = editingName.trimmingCharacters(in: .whitespaces)
                            if !trimmed.isEmpty { playerName = trimmed }
                        }
                    Button {
                        let trimmed = editingName.trimmingCharacters(in: .whitespaces)
                        if !trimmed.isEmpty { playerName = trimmed }
                    } label: {
                        Text("Update Name")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .frame(maxWidth: .infinity)
                    }
                    .disabled(editingName.trimmingCharacters(in: .whitespaces).isEmpty)
                } header: {
                    Text("Player Name")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
            .onAppear {
                editingName = playerName
            }
            .fullScreenCover(isPresented: $showParentalGate) {
                ParentalGateView {
                    showSubscription = true
                }
            }
            .sheet(isPresented: $showSubscription) {
                SubscriptionView()
            }
        }
    }
}
