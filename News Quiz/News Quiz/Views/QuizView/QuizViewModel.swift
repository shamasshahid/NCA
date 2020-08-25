//
//  QuizViewModel.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

enum DataFetchState {
    case isFetching
    case isSuccessful
    case isFailed
}

class QuizViewModel {
    
    private let dependencyProvider: NetworkDependencies
    private var currentIndex: Int = 0
    private let scoreKeeper = ScoreKeeper()
    private var wasLastResponseCorrect: Bool = false
    private var dataFetchState: DataFetchState = .isFetching {
        didSet {
            onDataFetchStateChanged?(dataFetchState)
        }
    }
    
    private var quizData: [QuizItem] = [] {
        didSet {
            if let question = getItemForCurrentIndex() {
                onQuestionSet?(question)
            }
            
        }
    }
    
    var onScoreUpdated: ((String) -> Void)?
    var onProgressUpdated: ((Float) -> Void)?
    var onShowResult: (() -> Void)?
    var onDataFetchStateChanged: ((DataFetchState) -> Void)?
    var onQuestionSet: ((QuizItem) -> Void)?
    
    init(provider: NetworkDependencies) {
        dependencyProvider = provider
    }
    
    func updateScoreForAnswer(isCorrect: Bool) {
        wasLastResponseCorrect = isCorrect
        scoreKeeper.answerSelected(isCorrect: isCorrect)
        onScoreUpdated?("\(scoreKeeper.score)")
        onProgressUpdated?(getCurrentProgress())
        onShowResult?()
    }
    
    private func getCurrentProgress() -> Float {
        guard quizData.count > 0 else {
            return 0
        }
        return Float(currentIndex + 1) / Float(quizData.count)
    }
    
    private func setNextQuestionIfAvailable() {
        currentIndex += 1
        guard let question = getItemForCurrentIndex() else {
            // handle end of game
            return
        }
        
        onQuestionSet?(question)
    }
    
    func loadQuizData() {
        dataFetchState = .isFetching
        let service = dependencyProvider.getService()
        let router = dependencyProvider.getRoutable()
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
        onProgressUpdated?(getCurrentProgress())
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
