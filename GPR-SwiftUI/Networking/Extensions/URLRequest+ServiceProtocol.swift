//
//  URLRequest+ServiceProtocol.swift
//  NetworkingLayer
//
//  Created by T. Fernandez on 19/05/2022.
//  Copyright (c) 2022 Tommy Fernandez. All rights reserved.
//

import Foundation

/// This extension is responsible for en easy-to-make API calls, creating the URLRequest from the ServiceProtocol and adding body params if needed
extension URLRequest {
    init(service: ServiceProtocol) throws {
        let urlComponents = try URLComponents(service: service)
        self.init(url: urlComponents.url!)
        httpMethod = service.method.rawValue
        service.headers?.forEach { key, value in
            addValue(value, forHTTPHeaderField: key)
        }
        
        addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard service.method != .get, let params = service.params else {
            return
        }
        
        let boundary = UUID().uuidString
        var data = Data()
        params.forEach { param in
            data.append(dataBody(value: param.value, for: param.key, with: boundary))
        }
        
        data.append("--\(boundary)--\r\n".data(using: .utf8)!)
        httpBody = data
        
        guard let contentLength = httpBody?.count else {
            return
        }
        
        addValue("\(contentLength)", forHTTPHeaderField: "Content-Length")
    }
    
    private func dataBody(value: Any, for key: String, with boundary: String) -> Data {
        var httpBody = "--\(boundary)\r\n"
        httpBody += "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n"
        httpBody += "\(value)\r\n"
        return httpBody.data(using: .utf8) ?? Data()
    }
}
