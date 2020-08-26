//
//  ViewController.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var skipButton: UIButton!
    // views for reconnection
    @IBOutlet weak var overLayView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var failedToConnectLabel: UILabel!
    
    let scoreMessge = "Your current score is %@"
    let resultSegue = "resultIdentifier"
    let gameEnded = "Game Ended"
    let gameEndMessage = "Game ended. Your score was %@"
    let restart = "Restart"
    
    var viewModel: QuizViewModel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewModel()
    }
    
    func setupViewModel() {
        viewModel = DependencyProvider.getQuizViewModel()
        viewModel.onScoreUpdated = { [weak self]  score in
            guard let self = self else {
                return
            }
            
            self.scoreLabel.text = String(format: self.scoreMessge, score)
        }
        
        viewModel.onProgressUpdated = { [weak self] progress in
            DispatchQueue.main.async {
                self?.progressBar.progress = progress
            }
        }
        
        viewModel.onShowResult = { [weak self] in
            guard let self = self else {
                return
            }
            self.createAndShowResultView()
        }
        
        viewModel.onDataFetchStateChanged = { [weak self] state in
            DispatchQueue.main.async {
                self?.updateViewForDataFetchState(state: state)
            }
        }
        
        viewModel.onGameEnd = { [weak self] score in
            self?.showGameEndedPrompt(score: score)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupQuizItemView()
        setupFirstLoadUI()
        viewModel.loadQuizData()
    }
    
    func setupQuizItemView() {
        
        if let vc = DependencyProvider.getQuestionViewController() {
            addChildViewController(view: containerView, childVC: vc)
            
            vc.viewModel.onUserChoseAnswer = viewModel.updateScoreForAnswer(isCorrect: )
            viewModel.onQuestionSet = vc.viewModel.setQuizItem(item: )
        }
    }
    
    func setupFirstLoadUI() {
        scoreLabel.text = String(format: scoreMessge, "0")
        
        skipButton.layer.cornerRadius = 5
        skipButton.clipsToBounds = true
    }

    func showGameEndedPrompt(score: String) {
        let message = String(format: gameEndMessage, score)
        let alertController = UIAlertController(title: gameEnded, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: restart, style: .default, handler: { (alert) in
            self.viewModel.loadQuizData()
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func retryButtonTapped(_ sender: UIButton) {
        viewModel.loadQuizData()
    }
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        viewModel.skipRequested()
    }
    
    func updateViewForDataFetchState(state: DataFetchState) {
        switch state {
        case .isFetching: // show spinner
            failedToConnectLabel.isHidden = true
            retryButton.isHidden = true
            activityIndicator.startAnimating()
            overLayView.isHidden = false
        case .isSuccessful: // hide loading elements
            activityIndicator.stopAnimating()
            retryButton.isHidden = true
            failedToConnectLabel.isHidden = true
            overLayView.isHidden = true
        case .isFailed: // show retry elements
            activityIndicator.stopAnimating()
            retryButton.isHidden = false
            failedToConnectLabel.isHidden = false
            overLayView.isHidden = false
        }
    }
    
    func createAndShowResultView() {
        self.performSegue(withIdentifier: resultSegue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultVC = segue.destination as? ResultViewController {
            resultVC.viewModel = viewModel.getResultViewModel()
        }
    }

}

