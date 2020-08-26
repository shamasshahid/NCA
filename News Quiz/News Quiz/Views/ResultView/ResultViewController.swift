//
//  ResultViewController.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    static let storyboardIdentifier = "ResultViewController"
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var quizImageView: UIImageView!
    @IBOutlet weak var headlineTextView: UITextView!
    @IBOutlet weak var nextQuestionButton: UIButton!
    
    var viewModel: ResultViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newsArticleVC = segue.destination as? NewsArticleViewController {
            newsArticleVC.viewModel = viewModel.getNewsArticleViewModel()
        }
    }
    
    @IBAction func nextQuestionTapped(_ sender: UIButton) {
        
        viewModel.onNextQuestionRequested()
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    func setupUI() {
        
        resultLabel.text = viewModel.getResultLabelMessage()
        resultLabel.layer.cornerRadius = 5
        resultLabel.clipsToBounds = true
        resultLabel.backgroundColor = viewModel.isCorrect ? UIColor.green : UIColor.red
        
        nextQuestionButton.layer.cornerRadius = 5
        nextQuestionButton.clipsToBounds = true
        
        headlineTextView.text = viewModel.getQuizHeadline()
        
        quizImageView.kf.setImage(with: viewModel.getImageURL())
    }
    
    
    
}
