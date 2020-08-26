//
//  MockNetworkDependencyProvider.swift
//  News QuizTests
//
//  Created by Shamas on 26/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

@testable import News_Quiz

class MockNetworkDependencyProvider: NetworkDependencies {
    func getService() -> WebService {
        return MockService()
    }
    
    func getRoutable() -> Routable {
        return BaseRouter()
    }
    
}
