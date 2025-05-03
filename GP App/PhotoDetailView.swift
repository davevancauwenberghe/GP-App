//
//  PhotoDetailView.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 03/05/2025.
//

import SwiftUI

/// Detail view displaying a full-screen photo with caption overlay
struct PhotoDetailView: View {
    let photo: Photo

    var body: some View {
        ZStack(alignment: .bottom) {
            // Background
            Color.black
                .ignoresSafeArea()

            // Photo
            Image(photo.name)
                .resizable()
                .scaledToFit()
                .ignoresSafeArea(.all, edges: .top)

            // Caption
            Text(photo.name)
                .padding(8)
                .background(Color.black.opacity(0.6))
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.bottom, 16)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
