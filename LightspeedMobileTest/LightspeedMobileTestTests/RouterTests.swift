//
//  RouterTests.swift
//  LightspeedMobileTestTests
//
//  Created by Michael Charland on 2025-09-10.
//

import Foundation
@testable import LightspeedMobileTest
import Testing

struct RouterTests {

    @Test func createURL() async throws {
        let router = Router.fetchPhotos
        let request = try await router.asURLRequest()
        #expect(request.url?.absoluteString == "https://picsum.photos/v2/list")
        #expect(request.httpMethod?.lowercased() == "get")
    }

}
