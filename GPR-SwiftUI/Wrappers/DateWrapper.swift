//
//  DateWrapper.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import Foundation

public protocol DateValueCodableStrategy {
    associatedtype RawValue: Codable

    static func decode(_ value: RawValue) throws -> Date
    static func encode(_ date: Date) -> RawValue
}

// Property wrapper to use as a way to transform Date as a Codable with a specific strategy when decoding/encoding
@propertyWrapper struct DateFormatted<T: DateValueCodableStrategy>: Codable {
    private let value: T.RawValue
    var wrappedValue: Date
    
    public init(wrappedValue: Date) {
        self.wrappedValue = wrappedValue
        self.value = T.encode(wrappedValue)
    }
    
    public init(from decoder: Decoder) throws {
        self.value = try T.RawValue(from: decoder)
        self.wrappedValue = try T.decode(value)
    }
    
    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}

// Specific strategy used for GitHub API request
struct GitHubDateStrategy: DateValueCodableStrategy {
    private static var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    static func decode(_ value: String) throws -> Date {
        formatter.date(from: value) ?? Date()
    }
    
    static func encode(_ date: Date) -> String {
        formatter.string(from: date)
    }
}
