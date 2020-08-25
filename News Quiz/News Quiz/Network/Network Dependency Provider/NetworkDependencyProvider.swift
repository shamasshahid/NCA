//
//  NetworkDependencyProvider.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

/// Protocol which defines the required service and routable
protocol NetworkDependencies {
    func getService() -> WebService
    func getRoutable() -> Routable
}

/// Implementation for ConverterDependencies which returns WebService, and Routable
class NetworkDependencyProvider: NetworkDependencies {
    
    func getService() -> WebService {
        return QuizDataFetchService()
    }

    func getRoutable() -> Routable {
        return BaseRouter()
    }
}
