//
//  BaseRouter.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

/// Implements Routable protocol and is used to get the urlRequest
struct BaseRouter: Routable {
    
    var methodType: HTTPType {
        return .GET
    }
    
    var scheme: RoutableScheme {
        return .https
    }
    
    var baseURL: String {
        return "firebasestorage.googleapis.com"
    }
    
    var path: String {
        return "/v0/b/nca-dna-apps-dev.appspot.com/o/game.json"
    }
    
    var queryItems: [URLQueryItem] {
        return [URLQueryItem(name: "alt", value: "media"),
                URLQueryItem(name: "token", value: "e36c1a14-25d9-4467-8383-a53f57ba6bfe")]
    }
    
    var headers: [String : Any] {
        return [:]
    }
    
    
    /// Creates a URLRequest object using the implemented Routable protocol
    /// - Throws: RouteError
    /// - Returns: URLRequest
    func asURLRequest() throws -> URLRequest {
        
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = baseURL
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else{
            throw RouteError.invalidRoute
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = methodType.rawValue
        
        for headerField in headers.keys {
            request.setValue(headers[headerField] as? String, forHTTPHeaderField: headerField)
        }
        
        return request
    }
}
