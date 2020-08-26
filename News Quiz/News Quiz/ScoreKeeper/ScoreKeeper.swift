//
//  ScoreKeeper.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

/// `ScoreKeeper` is a light weight class that keeps track of the score
class ScoreKeeper {
    
    var score: Int = 0
    
    /// Used when an answer/outcome has come through
    /// - Parameter isCorrect: Bool whether the answer is correct or not
    func answerSelected(isCorrect: Bool) {
        score += isCorrect ? 2 : -1
    }
}
