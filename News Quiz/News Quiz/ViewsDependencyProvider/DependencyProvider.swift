//
//  ViewDependencyProvider.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation
import UIKit

class DependencyProvider {
    
    static func getQuestionViewController() -> QuestionViewController? {
        
        guard let vc = UIViewController.instantiateFromStoryBoard(identifier: QuestionViewController.storyboardIdentifier, type: DependencyProvider.self) as? QuestionViewController else {
            return nil
        }
        
        vc.viewModel = QuestionViewModel()
        
        return vc
    }
    
    static func getQuizViewModel() -> QuizViewModel {
        return QuizViewModel(provider: NetworkDependencyProvider())
    }
    
}
