import Foundation

struct Photo: Identifiable, Hashable {
    let assetName: String
    let title: String
    let collection: Collection
    let details: String
    var id: String { assetName }

    init(assetName: String, title: String, collection: Collection, details: String) {
        self.assetName = assetName
        self.title = title
        self.collection = collection
        self.details = details
    }

    enum Collection: String, CaseIterable, Identifiable {
        case featured = "Featured"
        case new = "New"
        case landscape = "Landscape"
        case portrait = "Portrait"
        case vault = "Vault"
        var id: Self { self }
        var symbol: String {
            switch self {
            case .featured: "sparkles"
            case .new: "clock"
            case .landscape: "mountain.2"
            case .portrait: "rectangle.portrait"
            case .vault: "lock.shield"
            }
        }
    }
}
