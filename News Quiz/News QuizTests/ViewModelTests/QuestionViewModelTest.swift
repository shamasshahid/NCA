//
//  QuestionViewModelTest.swift
//  News QuizTests
//
//  Created by Shamas on 26/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import XCTest

@testable import News_Quiz

class QuestionViewModelTest: XCTestCase {

    var viewModel: QuestionViewModel!
    
    override func setUpWithError() throws {
        
        viewModel = QuestionViewModel()
    }

    override func tearDownWithError() throws {
        
        viewModel = nil
    }

    func testViewModel() throws {
        viewModel.setQuizItem(item: QuestionViewModelTest.getQuizItem())
        XCTAssertEqual(viewModel.getOptionTitleFor(index: 0), "Option 1")
        XCTAssertEqual(viewModel.getImageURL(), URL(string: "http://news-innovation.s3.amazonaws.com/matcha/20150105/d6a7bac9beaefea3120a8fee51eaca29.jpg"))
        
        let expectationUserChoiceCallback = XCTestExpectation(description: "should invoke callback")
        viewModel.onUserChoseAnswer = { isCorrect in
            XCTAssertEqual(isCorrect, true)
            expectationUserChoiceCallback.fulfill()
        }
        viewModel.userSelectedAnswerIndex(index: 1)
        wait(for: [expectationUserChoiceCallback], timeout: 5)
        
    }

    static func getQuizItem() -> QuizItem {

        let item = QuizItem(correctAnswerIndex: 1, imageURL: "http://news-innovation.s3.amazonaws.com/matcha/20150105/d6a7bac9beaefea3120a8fee51eaca29.jpg", standFirst: "stand first title", storyURL: "http://www.dailytelegraph.com.au/sport/football/barclays-premier-league-leaders-chelsea-held-to-1-1-draw-by-top-four-contenders-southampton/story-fnk5e6j5-1227168894043?sv=4cb49dd02de058ab862ac225a8e18fd5", section: .entertainment, headlines: ["Option 1", "Option 2", "Option 3"])
        return item
    }
}
