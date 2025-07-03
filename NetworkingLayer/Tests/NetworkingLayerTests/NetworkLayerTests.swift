//
//  NetworkingLayerTests.swift
//  NetworkingLayer
//
//  Created by T. Fernandez on 19/05/2022.
//  Copyright (c) 2022 Tommy Fernandez. All rights reserved.
//

import XCTest
@testable import NetworkingLayer

final class NetworkingLayerTests: XCTestCase {
    var response: NetworkResponse?
    
    struct Request: ServiceProtocol {
        var baseURL: URL?
        var path: String
        var method: HTTPMethod
    }
    
    func testGetMethod() async {
        let urlString = "https://httpbin.org/"
        guard let url = URL(string: urlString) else {
            XCTFail("Failed to create URL")
            return
        }
        
        let simpleService = Request(baseURL: url, path: "get", method: .get)
        let response = await URLSessionProvider().request(service: simpleService)
        switch response {
        case .success(let data):
            if let json = data.jsonValue as? JSON, let jsonUrl = json["url"] as? String {
                XCTAssertEqual(simpleService.absolutePath, jsonUrl)
            } else {
                XCTFail("Failed to retrieve data from server")
            }
        default:
            XCTFail("Failed to retrieve data from server")
            break
        }
    }
}
