//
//  QuizViewModelTest.swift
//  News QuizTests
//
//  Created by Shamas on 26/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import XCTest

@testable import News_Quiz

class QuizViewModelTest: XCTestCase {

    var viewModel: QuizViewModel!
    
    override func setUpWithError() throws {
        
        viewModel = QuizViewModel(provider: MockNetworkDependencyProvider())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testViewModel() throws {
        
        let expectationState = XCTestExpectation(description: "State should change Expectation")
        viewModel.onDataFetchStateChanged = { state in
            
            expectationState.fulfill()
        }
        viewModel.loadQuizData()
        wait(for: [expectationState], timeout: 5)
        
        let expectationProgress = XCTestExpectation(description: "Progress should increase")
        viewModel.onProgressUpdated = { progress in
            XCTAssertEqual(progress, 1 / 3)
            expectationProgress.fulfill()
        }
        
        let expectationScoreChange = XCTestExpectation(description: "Score should increase")
        viewModel.onScoreUpdated = { score in
            XCTAssertEqual(score, "2")
            expectationScoreChange.fulfill()
        }
        viewModel.updateScoreForAnswer(isCorrect: true)
        wait(for: [expectationProgress, expectationScoreChange], timeout: 5)
        
    }
    
    func testGetResultViewModel() throws {
        
        viewModel.loadQuizData()
        viewModel.updateScoreForAnswer(isCorrect: false)
        let resultViewModel = viewModel.getResultViewModel()
        XCTAssertEqual(resultViewModel?.isCorrect,  false)
    }
    
    func testSkipRequested() throws {
        
        viewModel.loadQuizData()
        let skipExpectation = XCTestExpectation(description: "should skip")
        skipExpectation.expectedFulfillmentCount = 2
        
        viewModel.onProgressUpdated = { _ in
            skipExpectation.fulfill()
        }
        viewModel.skipRequested()
        viewModel.skipRequested()
        wait(for: [skipExpectation], timeout: 5)
    }

}
