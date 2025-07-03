//
//  URLSessionProvider.swift
//  NetworkingLayer
//
//  Created by T. Fernandez on 19/05/2022.
//  Copyright (c) 2022 Tommy Fernandez. All rights reserved.
//

import Foundation

/// The provider that creates an API call and handles the response
public class URLSessionProvider: ProviderProtocol {
    private var session: URLSessionProtocol
    
    public init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    public func request(service: ServiceProtocol) async -> NetworkResponse {
        do {
            let request = try URLRequest(service: service)
            let task = try await session.dataTask(request: request)
            let httpResponse = task.response as? HTTPURLResponse
            let networkResponse = self.handleDataResponse(data: task.data, response: httpResponse)
            debug(service: service, with: networkResponse)
            return networkResponse
        } catch(let error) {
            guard let error = error as? NetworkError else {
                return .failure(.unknown)
            }
            
            return .failure(error)
        }
    }
    
    private func handleDataResponse(data: Data?, response: HTTPURLResponse?) -> NetworkResponse {
        var networkResponse: NetworkResponse
        
        guard let response = response else {
            return .failure(.unknown)
        }
        
        switch response.statusCode {
        case 200...299:
            guard let data = data else {
                return .failure(.unknown)
            }
            
            networkResponse = .success(data)
        default:
            networkResponse = .failure(.responseError(message: nil, code: response.statusCode))
            
            if let data = data {
                if let json = data.jsonValue as? JSON {
                    networkResponse = .failure(.jsonError(json: json))
                } else if let message = String(data: data, encoding: .utf8) {
                    networkResponse = .failure(.responseError(message: message, code: response.statusCode))
                }
            }
        }
        
        return networkResponse
    }
}
