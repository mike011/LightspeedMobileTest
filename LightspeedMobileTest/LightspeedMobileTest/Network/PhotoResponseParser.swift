//
//  PhotoResponseParser.swift
//  LightspeedMobileTest
//
//  Created by Michael Charland on 2025-09-10.
//

import Foundation

struct PhotoResponseParser {

    static func parse(from data: Data) throws -> PhotoResponse {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let photoData = try decoder.decode(PhotoResponse.self, from: data)
        return photoData
    }
}
