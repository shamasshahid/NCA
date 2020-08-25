//
//  NewsArticleViewModelTest.swift
//  News QuizTests
//
//  Created by Shamas on 26/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import XCTest

@testable import News_Quiz

class NewsArticleViewModelTest: XCTestCase {

    var viewModel: NewsArticleViewModel!
    
    override func setUpWithError() throws {
        
        viewModel = NewsArticleViewModel(item: QuestionViewModelTest.getQuizItem())
    }

    override func tearDownWithError() throws {
        
        viewModel = nil
    }

    func testViewModel() throws {
        
        XCTAssertEqual(viewModel.getNewsArticleURL(), URL(string: "http://www.dailytelegraph.com.au/sport/football/barclays-premier-league-leaders-chelsea-held-to-1-1-draw-by-top-four-contenders-southampton/story-fnk5e6j5-1227168894043?sv=4cb49dd02de058ab862ac225a8e18fd5"))
    }

}
