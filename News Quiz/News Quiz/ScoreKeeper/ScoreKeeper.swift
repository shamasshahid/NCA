//
//  ScoreKeeper.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

class ScoreKeeper {
    
    var score: Int = 0
    
    func answerSelected(isCorrect: Bool) {
        score += isCorrect ? 2 : -1
    }
}
