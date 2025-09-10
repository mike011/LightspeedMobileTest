//
//  URLSessionType.swift
//  LightspeedMobileTest
//
//  Created by Michael Charland on 2025-09-10.
//

import Foundation

protocol URLSessionType {
    static var shared: URLSession { get }
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionType {
}
