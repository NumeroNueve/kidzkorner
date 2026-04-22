import SwiftUI

struct DrawingCanvasView: View {
    @StateObject private var store = DrawingStore()
    @State private var lines: [DrawingLine] = []
    @State private var currentLine = DrawingLine()
    @State private var selectedColor: Color = .black
    @State private var lineWidth: CGFloat = 5.0
    @State private var showSaved = false
    @State private var canvasSize: CGSize = .zero

    private let colors: [Color] = [
        .black, .red, .orange, .yellow, .green,
        .blue, .purple, .pink, .brown, .white
    ]

    var body: some View {
        VStack(spacing: 0) {
            canvas
            colorPalette
            toolbar
        }
        .navigationTitle("Drawing")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $showSaved) {
            DrawingLibraryView(store: store)
        }
    }

    private var canvas: some View {
        GeometryReader { geo in
        Canvas { context, size in
            for line in lines {
                var path = Path()
                guard let first = line.points.first else { continue }
                path.move(to: first)
                for point in line.points.dropFirst() {
                    path.addLine(to: point)
                }
                context.stroke(path, with: .color(Color(uiColor: line.color)), lineWidth: line.lineWidth)
            }

            var currentPath = Path()
            if let first = currentLine.points.first {
                currentPath.move(to: first)
                for point in currentLine.points.dropFirst() {
                    currentPath.addLine(to: point)
                }
                context.stroke(currentPath, with: .color(Color(uiColor: currentLine.color)), lineWidth: currentLine.lineWidth)
            }
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onAppear { canvasSize = geo.size }
        .onChange(of: geo.size) { _, newSize in canvasSize = newSize }
        }
        .padding(.horizontal, 8)
        .padding(.top, 8)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    if currentLine.points.isEmpty {
                        currentLine.color = UIColor(selectedColor)
                        currentLine.lineWidth = lineWidth
                    }
                    currentLine.points.append(value.location)
                }
                .onEnded { _ in
                    lines.append(currentLine)
                    currentLine = DrawingLine()
                }
        )
    }

    private var colorPalette: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Circle()
                                .stroke(selectedColor == color ? .white : .clear, lineWidth: 3)
                        )
                        .overlay(
                            Circle()
                                .stroke(selectedColor == color ? .gray : .gray.opacity(0.3), lineWidth: 1)
                        )
                        .onTapGesture { selectedColor = color }
                }

                Divider().frame(height: 30)

                HStack(spacing: 8) {
                    Circle()
                        .fill(.gray)
                        .frame(width: 16, height: 16)
                        .onTapGesture { lineWidth = 3 }
                        .overlay(Circle().stroke(lineWidth == 3 ? .white : .clear, lineWidth: 2))

                    Circle()
                        .fill(.gray)
                        .frame(width: 24, height: 24)
                        .onTapGesture { lineWidth = 5 }
                        .overlay(Circle().stroke(lineWidth == 5 ? .white : .clear, lineWidth: 2))

                    Circle()
                        .fill(.gray)
                        .frame(width: 34, height: 34)
                        .onTapGesture { lineWidth = 10 }
                        .overlay(Circle().stroke(lineWidth == 10 ? .white : .clear, lineWidth: 2))
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 10)
    }

    private var toolbar: some View {
        HStack(spacing: 20) {
            Button {
                if !lines.isEmpty {
                    lines.removeLast()
                }
            } label: {
                Label("Undo", systemImage: "arrow.uturn.backward")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
            }
            .disabled(lines.isEmpty)

            Button {
                lines.removeAll()
            } label: {
                Label("Clear", systemImage: "trash")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
            }
            .disabled(lines.isEmpty)

            Spacer()

            Button {
                showSaved = true
            } label: {
                Image(systemName: "photo.on.rectangle")
                    .font(.system(size: 24))
            }

            Button {
                saveDrawing()
            } label: {
                Image(systemName: "square.and.arrow.down")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(.green.gradient, in: Circle())
            }
            .disabled(lines.isEmpty)
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
    }

    private func saveDrawing() {
        let renderer = ImageRenderer(content:
            Canvas { context, size in
                for line in lines {
                    var path = Path()
                    guard let first = line.points.first else { continue }
                    path.move(to: first)
                    for point in line.points.dropFirst() {
                        path.addLine(to: point)
                    }
                    context.stroke(path, with: .color(Color(uiColor: line.color)), lineWidth: line.lineWidth)
                }
            }
            .frame(width: canvasSize.width, height: canvasSize.height)
            .background(.white)
        )
        renderer.scale = 2.0
        if let image = renderer.uiImage {
            store.save(image: image)
            lines.removeAll()
        }
    }
}
