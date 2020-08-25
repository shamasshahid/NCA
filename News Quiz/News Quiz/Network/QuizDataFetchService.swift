//
//  QuizDataFetchService.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

class QuizDataFetchService: WebService {
    
    let session = URLSession.shared
    
    func fetch(urlRequest: Routable, completionHandler: @escaping (Result<QuizResponse, ServiceError>) -> Void) {
        
        do {
            let task = try session.dataTask(with: urlRequest.asURLRequest(), completionHandler: { (dataResponse, responseObject, error) in
                
                guard let data = dataResponse else {
                    completionHandler(.failure(.checkNetworkMaybe))
                    return
                }

                do {
                    let response = try JSONDecoder().decode(QuizResponse.self, from: data)
                    completionHandler(.success(response))
                } catch {
                    // return parsing failed error
                    completionHandler(.failure(.invalidResponseStructure))
                }
            })
            task.resume()
        } catch {
            completionHandler(.failure(.invalidURL))
        }
    }
}
