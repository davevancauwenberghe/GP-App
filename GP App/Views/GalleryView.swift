import SwiftUI

struct GalleryView: View {
    let photos: [Photo]
    let isVault: Bool
    @State private var selection: Photo.Collection?
    @State private var query = ""
    @Environment(\.horizontalSizeClass) private var sizeClass

    private var collections: [Photo.Collection] {
        Photo.Collection.allCases.filter { isVault ? $0 == .vault : $0 != .vault }
    }
    private var filtered: [Photo] {
        photos.filter { photo in
            (selection == nil || photo.collection == selection) &&
            (query.isEmpty || photo.title.localizedStandardContains(query))
        }
    }
    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: sizeClass == .regular ? 260 : 156), spacing: 12)]
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if isVault { VaultHeader() }
                collectionPicker
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(filtered) { photo in
                        NavigationLink(value: photo) { PhotoCard(photo: photo, isVault: isVault) }
                            .buttonStyle(.plain)
                    }
                }
            }
            .padding()
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle(isVault ? "The Vault" : "Portfolio")
        .navigationDestination(for: Photo.self) { PhotoDetailView(photo: $0) }
        .searchable(text: $query, prompt: "Search locations")
        .overlay { if filtered.isEmpty { EmptyGalleryView(query: query) } }
    }

    private var collectionPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                FilterButton(title: "All", symbol: "square.grid.2x2", selected: selection == nil) { selection = nil }
                ForEach(collections) { item in
                    FilterButton(title: item.rawValue, symbol: item.symbol, selected: selection == item) { selection = item }
                }
            }
        }
        .accessibilityLabel("Photo collections")
    }
}

private struct FilterButton: View {
    let title: String
    let symbol: String
    let selected: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action) { Label(title, systemImage: symbol).font(.subheadline.weight(.semibold)).padding(.horizontal, 14).padding(.vertical, 9) }
            .buttonStyle(.plain).foregroundStyle(selected ? Color.white : .primary)
            .background(selected ? Color.accentColor : Color(uiColor: .secondarySystemGroupedBackground), in: Capsule())
            .accessibilityAddTraits(selected ? .isSelected : [])
    }
}

private struct VaultHeader: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: "lock.shield.fill").font(.largeTitle).foregroundStyle(.orange)
            Text("Beyond the portfolio").font(.title2.bold())
            Text("A private collection of photographs available exclusively in GP App.").foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading).padding(20)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 24))
        .accessibilityElement(children: .combine)
    }
}

private struct EmptyGalleryView: View {
    let query: String
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "photo.badge.magnifyingglass").font(.largeTitle).foregroundStyle(.secondary)
            Text("No photographs found").font(.headline)
            Text(query.isEmpty ? "Choose another collection." : "Try a different search.").foregroundStyle(.secondary)
        }.padding().accessibilityElement(children: .combine)
    }
}
