//
//  ViewDependencyProvider.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation
import UIKit

/// DependencyProvider is used to do tie up between views and their viewmodels.
/// It creates `QuestionViewController`, assigns it its viewmodel and returns it
class DependencyProvider {
    
    static func getQuestionViewController() -> QuestionViewController? {
        
        guard let vc = UIViewController.instantiateFromStoryBoard(identifier: QuestionViewController.storyboardIdentifier, type: DependencyProvider.self) as? QuestionViewController else {
            return nil
        }
        
        vc.viewModel = QuestionViewModel()
        
        return vc
    }
    
    /// Creates `QuizViewModel` with `NetworkDependencyProvider` and returns
    /// - Returns: QuizViewModel
    static func getQuizViewModel() -> QuizViewModel {
        return QuizViewModel(provider: NetworkDependencyProvider())
    }
    
}
