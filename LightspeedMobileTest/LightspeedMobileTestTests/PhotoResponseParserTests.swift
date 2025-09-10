//
//  PhotoResponseParserTests.swift
//  LightspeedMobileTestTests
//
//  Created by Michael Charland on 2025-09-10.
//

import Foundation
@testable import LightspeedMobileTest
import Testing

@Suite
struct PhotoResponseParserTests {

    @MainActor
    @Test func parseValid() async throws {
        let result = try PhotoResponseParser.parse(from: PhotoResponse.oneValidPhoto)
        #expect(result.count == 1)
        #expect(result[0].id == "0")
        #expect(result[0].author == "Author")
        #expect(result[0].downloadURL == "https://picsum.photos/id/0")
    }

}
