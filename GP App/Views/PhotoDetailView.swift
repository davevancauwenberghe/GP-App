import SwiftUI

struct PhotoDetailView: View {
    let photo: Photo
    @State private var zoom: CGFloat = 1
    @State private var lastZoom: CGFloat = 1
    @State private var showingDetails = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        GeometryReader { proxy in
            ScrollView([.horizontal, .vertical]) {
                Image(photo.assetName)
                    .resizable().scaledToFit()
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .scaleEffect(zoom)
                    .gesture(MagnificationGesture().onChanged { zoom = min(max(lastZoom * $0, 1), 5) }.onEnded { _ in lastZoom = zoom })
                    .onTapGesture(count: 2) {
                        if reduceMotion { zoom = zoom > 1 ? 1 : 2; lastZoom = zoom }
                        else { withAnimation(.easeInOut(duration: 0.25)) { zoom = zoom > 1 ? 1 : 2; lastZoom = zoom } }
                    }
                    .accessibilityLabel("Photograph of \(photo.title)")
                    .accessibilityHint("Pinch or double tap to zoom")
            }
            .background(Color.black)
        }
        .navigationTitle(photo.title).navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar).toolbarBackground(.black, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button { showingDetails = true } label: {
                    Label("Photo information", systemImage: "info.circle")
                }
            }
        }
        .sheet(isPresented: $showingDetails) { PhotoInformationView(photo: photo) }
    }
}

private struct PhotoInformationView: View {
    let photo: Photo
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 18) {
                Label(photo.collection.rawValue, systemImage: photo.collection.symbol)
                    .font(.headline)
                    .foregroundStyle(.tint)
                Text(photo.details.isEmpty ? "More information about this photograph will be added soon." : photo.details)
                    .font(.body)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .navigationTitle(photo.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}
