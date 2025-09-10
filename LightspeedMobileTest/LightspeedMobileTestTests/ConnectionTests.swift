//
//  ConnectionTests.swift
//  LightspeedMobileTestTests
//
//  Created by Michael Charland on 2025-09-10.
//

import Foundation
@testable import LightspeedMobileTest
import Testing

struct ConnectionTests {

    struct FetchPhotos {

        @MainActor
        @Test func multiplePhotos() async throws {
            var session = MockURLSession()
            let photosJSON = PhotoResponse.multipleValidPhotos
            session.resultData = photosJSON
            let connection = Connection(session: session)
            let photos = try await connection.fetchPhotos()
            #expect(photos.count == 2)
        }

        @MainActor
        @Test func invalidResult() async throws {
            var session = MockURLSession()
            let photosJSON = PhotoResponse.invalidJSON
            session.resultData = photosJSON
            let connection = Connection(session: session)

            let error = await #expect(throws: (any Error).self) {
                try await connection.fetchPhotos()
            }
            #expect(error?.localizedDescription == "Fetch failed: The data couldn’t be read because it isn’t in the correct format. Response: invalid")
        }

        @MainActor
        @Test func noResultsFound() async throws {
            var session = MockURLSession()
            let photosJSON = PhotoResponse.emptyJSON
            session.resultData = photosJSON
            let connection = Connection(session: session)

            let photos = try await connection.fetchPhotos()
            #expect(photos.isEmpty)
        }
    }

    struct FetchPhoto {
        @MainActor
        @Test func noPhotosFound() async throws {
            var session = MockURLSession()
            let photosJSON = PhotoResponse.emptyJSON
            session.resultData = photosJSON
            let connection = Connection(session: session)

            let error = await #expect(throws: (any Error).self) {
                try await connection.fetchPhoto(index: 0)
            }
            #expect(error?.localizedDescription == "Fetch failed: No photos available.")
        }

        @MainActor
        @Test func invalidDownloadURL() async throws {
            var session = MockURLSession()
            let photosJSON = PhotoResponse.invalidDownloadURL
            session.resultData = photosJSON
            let connection = Connection(session: session)

            let error = await #expect(throws: (any Error).self) {
                try await connection.fetchPhoto(index: 0)
            }
            #expect(error?.localizedDescription == "Fetch failed: Invalid url for photo at ht!tp://invalid-url.")
        }

        @MainActor
        @Test func listIndexCorrectlySet() async throws {
            var session = MockURLSession()
            let photosJSON = PhotoResponse.oneValidPhoto
            session.resultData = photosJSON
            let connection = Connection(session: session)

            let photo = try await connection.fetchPhoto(index: 35)

            #expect(photo.listIndex == 35)
        }
    }
}
