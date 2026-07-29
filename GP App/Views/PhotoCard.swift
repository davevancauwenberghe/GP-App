import SwiftUI

struct PhotoCard: View {
    let photo: Photo
    let isVault: Bool

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(photo.assetName).resizable().scaledToFill().frame(height: 220).clipped()
            LinearGradient(colors: [.clear, .black.opacity(0.72)], startPoint: .center, endPoint: .bottom)
            VStack(alignment: .leading, spacing: 3) {
                Text(photo.title).font(.headline)
                Label(photo.collection.rawValue, systemImage: photo.collection.symbol).font(.caption)
            }
            .foregroundStyle(.white).padding(14)
            if isVault { Image(systemName: "lock.fill").foregroundStyle(.white).padding(12).background(.black.opacity(0.5), in: Circle()).padding(10).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing) }
        }
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: .black.opacity(0.12), radius: 8, y: 4)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(photo.title), \(photo.collection.rawValue) photograph")
        .accessibilityHint("Opens the photograph full screen")
    }
}
