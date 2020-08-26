//
//  QuizViewModel.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

/// Data Fetch State
enum DataFetchState {
    case isFetching
    case isSuccessful
    case isFailed
}

class QuizViewModel {
    
    private let dependencyProvider: NetworkDependencies
    private let scoreKeeper = ScoreKeeper()
    private var wasLastResponseCorrect: Bool = false
    
    // current Index of the question being sked
    private var currentIndex: Int = 0 {
        didSet {
            onProgressUpdated?(getCurrentProgress())
        }
    }
    
    private var dataFetchState: DataFetchState = .isFetching {
        didSet {
            onDataFetchStateChanged?(dataFetchState)
        }
    }
    
    private var quizData: [QuizItem] = [] {
        didSet {
            currentIndex = 0
            if let question = getItemForCurrentIndex() {
                onQuestionSet?(question)
            }
            
        }
    }
    
    // call back for the view to update the score
    var onScoreUpdated: ((String) -> Void)?
    
    // call back for the view to update the progress
    var onProgressUpdated: ((Float) -> Void)?
    
    // call back for the view show Result View
    var onShowResult: (() -> Void)?
    
    // call back for the view handle data fetch states
    var onDataFetchStateChanged: ((DataFetchState) -> Void)?
    
    // call back for the QuestionViewModel to update to new question
    var onQuestionSet: ((QuizItem) -> Void)?
    var onGameEnd: ((String) -> Void)?
    
    init(provider: NetworkDependencies) {
        dependencyProvider = provider
    }
    
    func updateScoreForAnswer(isCorrect: Bool) {
        wasLastResponseCorrect = isCorrect
        scoreKeeper.answerSelected(isCorrect: isCorrect)
        onScoreUpdated?("\(scoreKeeper.score)")
        onShowResult?()
    }
    
    private func getCurrentProgress() -> Float {
        // sanity check to prevent division by zero
        guard quizData.count > 0 else {
            return 0
        }
        return Float(currentIndex + 1) / Float(quizData.count)
    }
    
    private func setNextQuestionIfAvailable() {
        currentIndex += 1
        guard let question = getItemForCurrentIndex() else {
            onGameEnd?("\(scoreKeeper.score)")
            return
        }
        
        onQuestionSet?(question)
    }
    
    func loadQuizData() {
        dataFetchState = .isFetching
        let service = dependencyProvider.getService()
        let router = dependencyProvider.getRoutable()
        
        currentIndex = 0
        service.fetch(urlRequest: router) {[weak self] (result) in
            switch result {
            case .success(let response):
                self?.dataFetchState = .isSuccessful
                self?.quizData = response.items
            case .failure(_):
                self?.dataFetchState = .isFailed
            }
        }
    }
    
    func skipRequested() {
        setNextQuestionIfAvailable()
    }
    
    private func getItemForCurrentIndex() -> QuizItem? {
        guard currentIndex >= 0 && currentIndex < quizData.count else {
            return nil
        }
        return quizData[currentIndex]
    }
    
    
    func getResultViewModel() -> ResultViewModel? {
        
        guard let question = getItemForCurrentIndex() else {
            return nil
        }
        
        let viewModel = ResultViewModel(item: question, isCorrect: wasLastResponseCorrect)
        viewModel.onNextQuestion = { [weak self] in
            self?.setNextQuestionIfAvailable()
        }
        return viewModel
    }
    
}
