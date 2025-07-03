//
//  URLSessionProtocol.swift
//  NetworkingLayer
//
//  Created by T. Fernandez on 19/05/2022.
//  Copyright (c) 2022 Tommy Fernandez. All rights reserved.
//

import Foundation

public protocol URLSessionProtocol {
    typealias DataTaskResult = (data: Data, response: URLResponse)
    func dataTask(request: URLRequest) async throws -> DataTaskResult
}

extension URLSession: URLSessionProtocol {
    public func dataTask(request: URLRequest) async throws -> DataTaskResult {
        return try await data(for: request)
    }
}
