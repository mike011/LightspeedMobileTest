//
//  Connection.swift
//  LightspeedMobileTest
//
//  Created by Michael Charland on 2025-09-10.
//

import Foundation

struct Connection {

    static let shared = Connection()

    private let session: URLSessionType

    init(session: URLSessionType = URLSession.shared) {
        self.session = session
    }

    func fetchPhoto(index: Int) async throws -> Photo {
		let photos = try await fetchPhotos()
        guard let randomPhoto = photos.randomElement() else {
            throw NSError(domain: "FetchError", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "Fetch failed: No photos available."
            ])
        }

        guard let url = URL(string: randomPhoto.downloadURL) else {
            throw NSError(domain: "FetchError", code: 2, userInfo: [
                NSLocalizedDescriptionKey: "Fetch failed: Invalid url for photo at \(randomPhoto.downloadURL)."
            ])
        }

        let urlRequest = URLRequest(url: url)
		let (data, _) = try await session.data(for: urlRequest)

        return Photo(id: randomPhoto.id, author: randomPhoto.author, image: data, listIndex: index)
    }

    func fetchPhotos() async throws -> PhotoResponse {
        let urlRequest = try Router.fetchPhotos.asURLRequest()
        let (data, _) = try await session.data(for: urlRequest)
        do {
            return try PhotoResponseParser.parse(from: data)
        } catch {
            let responseString = String(data: data, encoding: .utf8) ?? "Unable to convert data to string"
            throw NSError(domain: "FetchError", code: 3, userInfo: [
                NSLocalizedDescriptionKey: "Fetch failed: \(error.localizedDescription) Response: \(responseString)"
            ])
        }
    }
}
