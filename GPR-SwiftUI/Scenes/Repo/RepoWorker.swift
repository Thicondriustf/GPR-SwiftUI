//
//  RepoWorker.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import Foundation
import NetworkingLayer

protocol RepoWorkerProtocol {
    /// Retrieve the repository from API
    /// - Parameters:
    ///   - name: Full name of the repository to request
    func getRepository(name: String) async -> NetworkResponse
    
    /// Retrieve all issues of a repository from API
    /// - Parameters:
    ///   - name: Full name of the repository to request
    ///   - startDate: Date after which all issues must be returned
    ///   - page: Page of the issues to retrieve from API
    func getIssues(name: String, from startDate: Date, page: Int) async -> NetworkResponse
}

final class RepoWorker {
    func getRepository(name: String) async -> NetworkResponse {
        return await URLSessionProvider().request(service: Request.getRepository(repoFullName: name))
    }
    
    func getIssues(name: String, from startDate: Date, page: Int) async -> NetworkResponse {
        return await URLSessionProvider().request(service: Request.getIssues(repoFullName: name, startDate: startDate, page: page))
    }
}
