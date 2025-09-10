//
//  Photo.swift
//  LightspeedMobileTest
//
//  Created by Michael Charland on 2025-09-10.
//

import Foundation
import SwiftData

@Model
class Photo {
    var id: String
    var author: String
    var listIndex: Int
    @Attribute(.externalStorage) var imageData: Data?

    init(id: String, author: String, image: Data?, listIndex: Int) {
        self.id = id
        self.author = author
        self.imageData = image
        self.listIndex = listIndex
    }
}
