//
//  NetworkResponse.swift
//  NetworkingLayer
//
//  Created by T. Fernandez on 19/05/2022.
//  Copyright (c) 2022 Tommy Fernandez. All rights reserved.
//

import Foundation

/// The two possible responses we can get from API response
public enum NetworkResponse {
    case success(Data)
    case failure(NetworkError)
}

/// The different possible errors that we can encounter when making API call
public enum NetworkError: Error {
    case urlError
    case networkMissing
    case timedOut
    case responseError(message: String?, code: Int)
    case jsonError(json: JSON)
    case unjsonable
    case undecodable
    case unknown
    case cancelled
}
