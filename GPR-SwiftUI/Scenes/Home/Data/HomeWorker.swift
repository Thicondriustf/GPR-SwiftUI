//
//  HomeWorker.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import NetworkingLayer

protocol HomeWorkerProtocol {
    /// Retrieve all public repositories from API
    /// - Parameters:
    ///   - id: API must send repositories prior this id
    func getRepositories(from id: Int) async -> NetworkResponse
}

final class HomeWorker: HomeWorkerProtocol {
    func getRepositories(from id: Int) async -> NetworkResponse {
        return await URLSessionProvider().request(service: Request.allRepositories(id: id))
    }
}
