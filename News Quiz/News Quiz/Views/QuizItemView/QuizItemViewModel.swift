//
//  QuizItemViewModel.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

class QuizItemViewModel {
    
    private var quizItem: QuizItem? {
        didSet {
            onViewRefreshed?()
        }
    }
    var onViewRefreshed: (() -> Void)?
    var onUserChoseAnswer: ((Bool) -> Void)?
    
    func setQuizItem(item: QuizItem) {
        quizItem = item
    }

    func getOptionTitleFor(index: Int) -> String {
        
        guard let item = quizItem, index >= 0 && index < item.headlines.count else {
            return ""
        }
        
        return item.headlines[index]
    }
    
    func getImageURL() -> URL? {
        guard let item = quizItem else {
            return nil
        }
        
        return URL(string: item.imageURL)
    }
    
    func userSelectedAnswerIndex(index: Int) {
        
        guard let item = quizItem else {
            return
        }
        
        onUserChoseAnswer?(index == item.correctAnswerIndex)
    }
}
