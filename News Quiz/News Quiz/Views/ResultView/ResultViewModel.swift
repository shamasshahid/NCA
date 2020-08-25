//
//  ResultViewModel.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

class ResultViewModel {
    
    static let correctMessage = "Correct"
    static let inCorrectMessage = "Incorrect"
    
    let quizItem: QuizItem
    let isCorrect: Bool
    
    var onNextQuestion: (() -> Void)?
    
    init(item: QuizItem, isCorrect: Bool) {
        quizItem = item
        self.isCorrect = isCorrect
    }
    
    func getResultLabelMessage() -> String {
        return isCorrect ? ResultViewModel.correctMessage : ResultViewModel.inCorrectMessage
    }
    
    func getQuizHeadline() -> String {
        return quizItem.standFirst
    }
    
    func getImageURL() -> URL? {
        
        return URL(string: quizItem.imageURL)
    }
    
    func onNextQuestionRequested() {
        onNextQuestion?()
    }
    
    func getNewsArticleViewModel() -> NewsArticleViewModel {
        return NewsArticleViewModel(item: quizItem)
    }
    
}
