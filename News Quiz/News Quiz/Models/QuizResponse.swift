//
//  QuizResponse.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

// MARK: - Quiz Response
struct QuizResponse: Codable {
    let product: String
    let resultSize, version: Int
    let items: [QuizItem]
}

