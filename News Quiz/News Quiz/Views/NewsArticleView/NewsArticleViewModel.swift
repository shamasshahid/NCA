//
//  NewsArticleViewModel.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

class NewsArticleViewModel {
    
    let quizItem: QuizItem
    
    init(item: QuizItem) {
        quizItem = item
    }
    
    func getNewsArticleURL() -> URL? {
        
        return URL(string: quizItem.storyURL)
    }
}
