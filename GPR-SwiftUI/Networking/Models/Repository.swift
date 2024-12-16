//
//  Repository.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

struct Repository: Codable {
    let id: Int
    let name: String
    let fullName: String
    let description: String?
    
    let openIssuesCount: Int?
    let forksCount: Int?
    let watchersCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case openIssuesCount = "open_issues_count"
        case forksCount = "forks_count"
        case watchersCount = "watchers_count"
        case description
    }
}
