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
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: DependencyProvider.self))
        guard let vc = storyboard.instantiateViewController(identifier: QuestionViewController.storyboardIdentifier) as? QuestionViewController else {
            return nil
        }
        
        vc.viewModel = QuestionViewModel()
        
        return vc
    }
    
    static func getQuizViewModel() -> QuizViewModel {
        return QuizViewModel(provider: NetworkDependencyProvider())
    }
    
}
