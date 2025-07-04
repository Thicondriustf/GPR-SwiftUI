//
//  IssuesRouter.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

protocol IssuesRoutingLogic {
    
}

protocol IssuesDataPassing {
    var dataStore: IssuesDataStore? { get set }
}

final class IssuesRouter: IssuesRoutingLogic, IssuesDataPassing {
    var dataStore: IssuesDataStore?
}
