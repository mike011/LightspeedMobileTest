//
//  LightspeedMobileTestApp.swift
//  LightspeedMobileTest
//
//  Created by Michael Charland on 2025-09-10.
//

import SwiftData
import SwiftUI

@main
struct LightspeedMobileTestApp: App {
    var body: some Scene {
        WindowGroup {
            PhotoCollectionView()
                .modelContainer(for: Photo.self)
        }
    }
}
