//
//  QuizItem.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

// MARK: - Item
struct QuizItem: Codable {
    let correctAnswerIndex: Int
    let imageURL: String
    let standFirst: String
    let storyURL: String
    let section: Section
    let headlines: [String]

    enum CodingKeys: String, CodingKey {
        case correctAnswerIndex
        case imageURL = "imageUrl"
        case standFirst
        case storyURL = "storyUrl"
        case section, headlines
    }
}

enum Section: String, Codable {
    case business = "business"
    case entertainment = "entertainment"
    case lifestyle = "lifestyle"
    case sport = "sport"
}
