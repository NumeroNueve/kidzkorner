import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var apiKeyText = ""
    @State private var hasKey = false

    private static let keychainKey = "anthropic_api_key"

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 12) {
                        if hasKey {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                                .font(.system(size: 22))
                            Text("API Key Saved")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                        } else {
                            Image(systemName: "key.fill")
                                .foregroundStyle(.secondary)
                                .font(.system(size: 22))
                            Text("No Key Configured")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundStyle(.secondary)
                        }
                    }

                    SecureField("sk-ant-...", text: $apiKeyText)
                        .font(.system(size: 16, design: .monospaced))
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()

                    Button {
                        let trimmed = apiKeyText.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !trimmed.isEmpty else { return }
                        KeychainHelper.save(key: Self.keychainKey, value: trimmed)
                        apiKeyText = ""
                        hasKey = true
                    } label: {
                        Text("Save Key")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity)
                    }
                    .disabled(apiKeyText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

                    if hasKey {
                        Button(role: .destructive) {
                            KeychainHelper.delete(key: Self.keychainKey)
                            hasKey = false
                        } label: {
                            Text("Remove Key")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .frame(maxWidth: .infinity)
                        }
                    }
                } header: {
                    Text("Anthropic API Key")
                } footer: {
                    Text("Enter your Anthropic API key to enable AI-generated stories. Without a key, stories use fun built-in templates.")
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
                hasKey = KeychainHelper.read(key: Self.keychainKey) != nil
            }
        }
    }
}
