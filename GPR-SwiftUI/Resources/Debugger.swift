//
//  Debugger.swift
//  NetworkingLayer
//
//  Created by T. Fernandez on 19/05/2022.
//  Copyright (c) 2022 Tommy Fernandez. All rights reserved.
//

import NetworkingLayer

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
