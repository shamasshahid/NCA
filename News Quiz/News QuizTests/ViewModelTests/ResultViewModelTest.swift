//
//  ResultViewModelTest.swift
//  News QuizTests
//
//  Created by Shamas on 26/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import XCTest

@testable import News_Quiz

class ResultViewModelTest: XCTestCase {

    var viewModel: ResultViewModel!
    
    override func setUpWithError() throws {
        
        viewModel = ResultViewModel(item: QuestionViewModelTest.getQuizItem(), isCorrect: true)
    }

    override func tearDownWithError() throws {
        
        viewModel = nil
    }

    func testViewModel() throws {
        
        XCTAssertEqual(viewModel.getResultLabelMessage(), "Correct")
        XCTAssertEqual(viewModel.getQuizHeadline(), "stand first title")
        XCTAssertEqual(viewModel.getImageURL(), URL(string: "http://news-innovation.s3.amazonaws.com/matcha/20150105/d6a7bac9beaefea3120a8fee51eaca29.jpg"))
        
        let expectation = XCTestExpectation(description: "should call back or next question")
        viewModel.onNextQuestion = {
            expectation.fulfill()
        }
        viewModel.onNextQuestionRequested()
        wait(for: [expectation], timeout: 5)
        
        let newsArticleVM = viewModel.getNewsArticleViewModel()
        XCTAssertNotNil(newsArticleVM)
    }
    

}
