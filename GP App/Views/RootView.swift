import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            NavigationStack { GalleryView(photos: PhotoLibrary.portfolio, isVault: false) }
                .tabItem { Label("Portfolio", systemImage: "photo.on.rectangle.angled") }
            NavigationStack { GalleryView(photos: PhotoLibrary.vault, isVault: true) }
                .tabItem { Label("Vault", systemImage: "lock.shield") }
            NavigationStack { AboutView() }
                .tabItem { Label("About", systemImage: "info.circle") }
        }
    }
}
