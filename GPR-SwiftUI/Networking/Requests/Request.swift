//
//  Request.swift
//  NetworkingLayer
//
//  Created by T. Fernandez on 19/05/2022.
//  Copyright (c) 2022 Tommy Fernandez. All rights reserved.
//

import Foundation
import NetworkingLayer

/// Enum of all API requests used in the app
enum Request: ServiceProtocol {
    case allRepositories(id: Int)
    case getRepository(repoFullName: String)
    case getIssues(repoFullName: String, startDate: Date, page: Int)
    
    var baseURL: URL? {
        return URL(string: "https://api.github.com/")
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .allRepositories:
            return "repositories"
        case .getRepository(let repoFullName):
            return "repos/" + repoFullName
        case .getIssues(let repoFullName, _, _):
            return "repos/" + repoFullName + "/issues"
        }
    }
    
    var params: JSON? {
        switch self {
        case .allRepositories(let id):
            return [
                "since": id
            ]
        case .getIssues(_, let startDate, let page):
            return [
                "state" : "all",
                "sort" : "created",
                "direction" : "asc",
                "since" : startDate.toString(format: "yyyy-MM-dd'T'HH:mm:ssZ"),
                "per_page" : 100,
                "page" : page
            ]
        default:
            return nil
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .allRepositories:
            return [
                "accept" : "application/vnd.github+json"
            ]
        default:
            return nil
        }
    }
}
