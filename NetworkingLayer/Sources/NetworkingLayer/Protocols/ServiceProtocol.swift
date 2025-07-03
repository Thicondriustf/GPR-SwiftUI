//
//  ServiceProtocol.swift
//  NetworkingLayer
//
//  Created by T. Fernandez on 19/05/2022.
//  Copyright (c) 2022 Tommy Fernandez. All rights reserved.
//

import Foundation

/// It implements a protocol that must be used to make API calls easily.

public typealias JSON = [ String : Any ]
public typealias HTTPHeaders = [ String : String ]

public protocol ServiceProtocol {
    var baseURL: URL? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var params: JSON? { get }
    var headers: HTTPHeaders? { get }
}

public extension ServiceProtocol {
    var absolutePath: String {
        guard let baseURL = baseURL else {
            return ""
        }
        
        return baseURL.absoluteString + path
    }
    
    var params: JSON? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
