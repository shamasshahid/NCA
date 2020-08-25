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
    @IBOutlet weak var quizHeadline: UILabel!
    
    var viewModel: ResultViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        
        resultLabel.text = viewModel.getResultLabelMessage()
        resultLabel.backgroundColor = viewModel.isCorrect ? UIColor.green : UIColor.red
        
        quizHeadline.text = viewModel.getQuizHeadline()
        
        quizImageView.kf.setImage(with: viewModel.getImageURL())
    }
    
    @IBAction func nextQuestionTapped(_ sender: UIButton) {
        
        viewModel.onNextQuestionRequested()
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newsArticleVC = segue.destination as? NewsArticleViewController {
            newsArticleVC.viewModel = viewModel.getNewsArticleViewModel()
        }
    }
    
}
