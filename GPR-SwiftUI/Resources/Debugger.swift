//
//  Debugger.swift
//  NetworkingLayer
//
//  Created by T. Fernandez on 19/05/2022.
//  Copyright (c) 2022 Tommy Fernandez. All rights reserved.
//

// The only purpose of this file is to log any information in Debug environment
func debug(service: ServiceProtocol, with networkReponse: NetworkResponse) {
    #if DEBUG
    let tag = "NetworkRequest"
    debug(tag, service.method.rawValue + " " + service.absolutePath, name: "URL")
    
    if let headers = service.headers {
        debug(tag, headers, name: "Headers")
    }
    
    if let params = service.params {
        debug(tag, params, name: "Parameters")
    }
    
    switch networkReponse {
    case .success(let data):
        if let json = data.jsonValue {
            debug(tag, json, name: "Result")
        } else {
            debug(tag, String(data: data, encoding: .utf8), name: "Result")
        }
    case .failure(let error):
        debug(tag, error, name: "Error")
    }
    #endif
}

func debug(_ tag: String, _ object: Any?, name: String? = nil) {
    #if DEBUG
    if let object = object, let name = name {
        print("[\(tag)] \(name) : \(object as AnyObject)")
    } else if let name = name {
        print("[\(tag)] \(name) : null")
    } else if let object = object {
        print("[\(tag)] \(object as AnyObject)")
    }
    #endif
}
