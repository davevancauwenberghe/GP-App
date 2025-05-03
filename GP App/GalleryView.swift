//
//  GalleryView.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 03/05/2025.
//

import SwiftUI

/// Model representing a photo asset in the gallery
struct Photo: Identifiable, Hashable {
    let id = UUID()
    let name: String  // image name in Assets.xcassets
}

/// A scrollable grid of photo thumbnails
struct GalleryView: View {
    private let columns = [
        GridItem(.adaptive(minimum: 120), spacing: 16)
    ]

    // Sample photo list. Replace with your actual asset names.
    private let photos: [Photo] = [
        Photo(name: "L1OudeDokken"),
        Photo(name: "L2OudeDokken"),
        Photo(name: "L3OudeDokken"),
        // Add more photos here...
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(photos, id: \ .self) { photo in
                    NavigationLink(value: photo) {
                        Image(photo.name)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 120)
                            .cornerRadius(8)
                            .clipped()
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Gallery")
        .navigationDestination(for: Photo.self) { photo in
            PhotoDetailView(photo: photo)
        }
    }
}
