//
//  PhotoResponse+Example.swift
//  LightspeedMobileTestTests
//
//  Created by Michael Charland on 2025-09-10.
//

import Foundation
@testable import LightspeedMobileTest

extension PhotoResponse {
    static let oneValidPhoto = """
[
  {
    "id": "0",
    "author": "Author",
    "width": 5000,
    "height": 3333,
    "url": "https://unsplash.com/photos/yC-Yzbqy7PY",
    "download_url": "https://picsum.photos/id/0"
  }
]
""".data(using: .utf8)!

static let multipleValidPhotos = """
    [
      {
        "id": "0",
        "author": "Alejandro Escamilla",
        "width": 5000,
        "height": 3333,
        "url": "https://unsplash.com/photos/yC-Yzbqy7PY",
        "download_url": "https://picsum.photos/id/0"
      },
      {
        "id": "1",
        "author": "Author 2",
        "width": 5000,
        "height": 3333,
        "url": "https://unsplash.com/photos/yC-Yzbqy7PY",
        "download_url": "https://picsum.photos/id/0"
      }
    ]
    """.data(using: .utf8)!

	static let invalidJSON = "invalid".data(using: .utf8)!

    static let emptyJSON = "[]".data(using: .utf8)!

    static let invalidDownloadURL  = """
[
  {
    "id": "0",
    "author": "Author",
    "width": 5000,
    "height": 3333,
    "url": "https://unsplash.com/photos/yC-Yzbqy7PY",
    "download_url": "ht!tp://invalid-url"
  }
]
""".data(using: .utf8)!
}


