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
    private let itemViewModel = QuizItemViewModel()
    private let scoreKeeper = ScoreKeeper()
    private var wasLastResponseCorrect: Bool = false
    private var dataFetchState: DataFetchState = .isFetching {
        didSet {
            onDataFetchStateChanged?(dataFetchState)
        }
    }
    
    private var quizData: [QuizItem] = [] {
        didSet {
            itemViewModel.setQuizItem(item: quizData[currentIndex])
        }
    }
    
    var onScoreUpdated: ((String) -> Void)?
    var onProgressUpdated: ((Float) -> Void)?
    var onShowResult: (() -> Void)?
    var onDataFetchStateChanged: ((DataFetchState) -> Void)?
    
    init(provider: NetworkDependencies) {
        dependencyProvider = provider
        setupQuizItemViewModel()
    }
    
    func setupQuizItemViewModel() {
        
        itemViewModel.onUserChoseAnswer = { [weak self] isCorrect in
            guard let self = self else {
                return
            }
            
            self.updateScoreForAnswer(isCorrect: isCorrect)
//            self.setNextQuestionIfAvailable()
        }
    }
    
    func updateScoreForAnswer(isCorrect: Bool) {
        wasLastResponseCorrect = isCorrect
        scoreKeeper.answerSelected(isCorrect: isCorrect)
        onScoreUpdated?("\(scoreKeeper.score)")
        onProgressUpdated?( Float(currentIndex) / Float(quizData.count))
        onShowResult?()
    }
    
    func setNextQuestionIfAvailable() {
        currentIndex += 1
        guard currentIndex < quizData.count else {
            // handle end of game
            return
        }
        
        itemViewModel.setQuizItem(item: quizData[currentIndex])
    }
    
    func requestQuizData() {
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
    }
    
    func getQuizItemViewModel() -> QuizItemViewModel {
        
        return itemViewModel
    }
    
    func getResultViweModel() -> ResultViewModel {
        
        let viewModel = ResultViewModel(item: quizData[currentIndex], isCorrect: wasLastResponseCorrect)
        viewModel.onNextQuestion = { [weak self] in
            self?.setNextQuestionIfAvailable()
        }
        return viewModel
    }
    
}
