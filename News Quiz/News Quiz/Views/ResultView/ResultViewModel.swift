//
//  ResultViewModel.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

class ResultViewModel {
    
    let quizItem: QuizItem
    let isCorrect: Bool
    
    init(item: QuizItem, isCorrect: Bool) {
        quizItem = item
        self.isCorrect = isCorrect
    }
    
    func getImageURL() -> URL? {
        
        return nil
    }
    
}
