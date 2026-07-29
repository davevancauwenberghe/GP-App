import SwiftUI

struct PhotoCard: View {
    let photo: Photo
    let isVault: Bool

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topTrailing) {
                Image(photo.assetName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                if isVault {
                    Image(systemName: "lock.fill")
                        .foregroundStyle(.white)
                        .padding(10)
                        .background(.black.opacity(0.55), in: Circle())
                        .padding(10)
                }
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(photo.title).font(.headline).foregroundStyle(.primary)
                Label(photo.collection.rawValue, systemImage: photo.collection.symbol)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.tint)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(14)
            .background(Color(uiColor: .secondarySystemGroupedBackground))
        }
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color.accentColor.opacity(0.35), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.12), radius: 8, y: 4)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(photo.title), \(photo.collection.rawValue) photograph")
        .accessibilityHint("Opens the photograph full screen")
    }
}
