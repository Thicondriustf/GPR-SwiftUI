//
//  Result.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import Foundation

struct Issue: Codable {
    enum Status: String, Codable {
        case open
        case closed
    }
    
    @DateFormatted<GitHubDateStrategy> var createdAt: Date
    var title: String
    var state: Status
    var draft: Bool?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case title
        case state
        case draft
    }
}

