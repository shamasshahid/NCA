//
//  MockService.swift
//  News QuizTests
//
//  Created by Shamas on 26/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

@testable import News_Quiz

class MockService: WebService {
    
    var mockContentData: Data {
        return getData(name: "quizData")
    }

    func getData(name: String, withExtension: String = "json") -> Data {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
        let data = try! Data(contentsOf: fileUrl!)
        return data
    }
    
    func fetch(urlRequest: Routable, completionHandler: @escaping (Result<QuizResponse, ServiceError>) -> Void) {
        let data = mockContentData
        if let response = try? JSONDecoder().decode(QuizResponse.self, from: data) {
            completionHandler(.success(response))
        }
    }
    
}
