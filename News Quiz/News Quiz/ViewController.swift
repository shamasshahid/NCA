//
//  ViewController.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let service = QuizDataFetchService()
        let router = BaseRouter()
        
        service.fetch(urlRequest: router) { (result) in
            switch result {
            case .success(let response):
                print(response.items.count)
            case .failure(let error):
                print(error)
            }
        }
    }

}

