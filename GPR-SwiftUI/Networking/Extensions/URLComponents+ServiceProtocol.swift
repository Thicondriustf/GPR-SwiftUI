//
//  URLComponents+ServiceProtocol.swift
//  NetworkingLayer
//
//  Created by T. Fernandez on 19/05/2022.
//  Copyright (c) 2022 Tommy Fernandez. All rights reserved.
//

import Foundation

/// This extension is responsible for en easy-to-make API calls adding query params if needed
extension URLComponents {
    init(service: ServiceProtocol) throws {
        guard let url = service.baseURL?.appendingPathComponent(service.path) else {
            throw NetworkError.urlError
        }
        
        self.init(url: url, resolvingAgainstBaseURL: false)!
        
        guard service.method == .get, let params = service.params else {
            return
        }
        
        queryItems = params.map { key, value in
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
}
