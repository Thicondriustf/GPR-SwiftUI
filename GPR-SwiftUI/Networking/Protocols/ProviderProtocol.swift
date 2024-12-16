//
//  ProviderProtocol.swift
//  NetworkingLayer
//
//  Created by T. Fernandez on 19/05/2022.
//  Copyright (c) 2022 Tommy Fernandez. All rights reserved.
//

import Foundation

protocol ProviderProtocol {
    func request(service: ServiceProtocol) async -> NetworkResponse
}
