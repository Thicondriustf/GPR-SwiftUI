//
//  Codable+Json.swift
//  NetworkingLayer
//
//  Created by T. Fernandez on 19/05/2022.
//  Copyright (c) 2022 Tommy Fernandez. All rights reserved.
//

import Foundation

extension Encodable {
    public var data: Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            debug(error, name: "Error")
            return nil
        }
    }
}

extension Decodable {
    public static func decode(from json: JSON) -> Self? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            return decode(from: jsonData)
        } catch {
            debug(error, name: "Error")
            return nil
        }
    }
    
    public static func decode(from data: Data) -> Self? {
        do {
            return try JSONDecoder().decode(self, from: data)
        } catch {
            debug(error, name: "Error")
            return nil
        }
    }
}

extension Data {
    var jsonValue: Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .allowFragments)
        } catch {
            debug(error, name: "Error")
            return nil
        }
    }
}
