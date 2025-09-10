//
//  MockURLSession.swift
//  LightspeedMobileTestTests
//
//  Created by Michael Charland on 2025-09-10.
//

import Foundation
@testable import LightspeedMobileTest

struct MockURLSession: URLSessionType {
    static var shared = URLSession.shared

    var resultData = Data()
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        return (resultData, URLResponse())
    }
    

}
