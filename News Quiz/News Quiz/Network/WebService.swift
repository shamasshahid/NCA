//
//  WebService.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    // url creation failed
    case invalidURL
    // no network error
    case checkNetworkMaybe
    // parse error
    case invalidResponseStructure
}

protocol WebService {
    
    /// Fetches data and returns it using the callback completion handler
    /// - Parameters:
    ///   - urlRequest: url Routable object which is used to create the urlRequest
    ///   - completionHandler: Completion Handler which contains the result enum
    ///    with success containing Products and error containg service error
    func fetch(urlRequest: Routable, completionHandler: @escaping (Result<QuizResponse, ServiceError>) -> Void)
}
