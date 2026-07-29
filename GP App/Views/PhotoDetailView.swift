import SwiftUI

struct PhotoDetailView: View {
    let photo: Photo
    @State private var zoom: CGFloat = 1
    @State private var lastZoom: CGFloat = 1
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
    }
}
