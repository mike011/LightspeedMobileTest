//
//  Router.swift
//  LightspeedMobileTest
//
//  Created by Michael Charland on 2025-09-10.
//

import Foundation

enum Router {
    static let baseURL = "https://picsum.photos/v2/"

    case fetchPhotos

    func asURLRequest() throws -> URLRequest {
        var method: String {
            switch self {
            case .fetchPhotos: return "get"
            }
        }

        let url: URL = {
            switch self {
            case .fetchPhotos: return createURL(withPath: "list")
            }
        }()

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        return urlRequest
    }

    func createURL(withPath path: String) -> URL {
        var url = URL(string: Self.baseURL)!
        url.appendPathComponent(path)
        return url
    }
}
