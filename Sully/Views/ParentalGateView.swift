import SwiftUI

struct ParentalGateView: View {
    let onPass: () -> Void
    @Environment(\.dismiss) private var dismiss

    @State private var a = Int.random(in: 12...29)
    @State private var b = Int.random(in: 3...9)
    @State private var answer = ""
    @State private var failed = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.85)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Text("Grown-Up Check")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Text("Only a parent or guardian should continue. Please solve this to proceed:")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundStyle(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                Text("What is \(a) x \(b)?")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundStyle(.yellow)

                TextField("Answer", text: $answer)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .padding(16)
                    .frame(width: 160)
                    .background(Color.white.opacity(0.15), in: RoundedRectangle(cornerRadius: 14))
                    .foregroundStyle(.white)

                if failed {
                    Text("That's not right. Try again!")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundStyle(.red)
                }

                HStack(spacing: 16) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundStyle(.white.opacity(0.7))
                            .padding(.horizontal, 32)
                            .padding(.vertical, 14)
                            .background(Color.white.opacity(0.12), in: Capsule())
                    }

                    Button {
                        if let num = Int(answer.trimmingCharacters(in: .whitespaces)), num == a * b {
                            dismiss()
                            onPass()
                        } else {
                            failed = true
                            answer = ""
                            a = Int.random(in: 12...29)
                            b = Int.random(in: 3...9)
                        }
                    } label: {
                        Text("Submit")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 14)
                            .background(Color.purple.gradient, in: Capsule())
                    }
                }
            }
            .padding(24)
        }
    }
}
