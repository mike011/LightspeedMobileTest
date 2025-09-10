//
//  PhotoView.swift
//  LightspeedMobileTest
//
//  Created by Michael Charland on 2025-09-10.
//

import SwiftUI

struct PhotoView: View {

    private let photo: Photo

    init(photo: Photo) {
        self.photo = photo
    }

    var body: some View {
        if let imageData = photo.imageData, let image = UIImage(data: imageData) {
            VStack(alignment: .center) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15)
                Text(photo.author)
                    .font(.title3)
            }
        } else {
            Text("Image not available for \(photo.author)")
                .foregroundColor(.red)
        }
    }
}

#Preview {
    @Previewable let image = UIImage(systemName: "photo")?.pngData()
    PhotoView(photo: Photo(id: "1", author: "Author", image: image, listIndex: 1))
}
