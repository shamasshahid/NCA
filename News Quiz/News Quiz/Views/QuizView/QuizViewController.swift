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
    
    var viewModel: QuizViewModel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupQuizItemView()
        setupFirstLoadUI()
        viewModel.requestQuizData()
    }
    
    func setupFirstLoadUI() {
        scoreLabel.text = String(format: scoreMessge, "0")
        
        skipButton.layer.cornerRadius = 5
        skipButton.clipsToBounds = true
    }

    @IBAction func retryButtonTapped(_ sender: UIButton) {
        viewModel.requestQuizData()
    }
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        viewModel.skipRequested()
    }
    func setupViewModel() {
        viewModel = QuizViewModel(provider: NetworkDependencyProvider())
        viewModel.onScoreUpdated = { [weak self]  score in
            guard let self = self else {
                return
            }
            
            self.scoreLabel.text = String(format: self.scoreMessge, score)
        }
        
        viewModel.onProgressUpdated = { [weak self] progress in
            self?.progressBar.progress = progress
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
    }
    
    func updateViewForDataFetchState(state: DataFetchState) {
        switch state {
        case .isFetching:
            failedToConnectLabel.isHidden = true
            retryButton.isHidden = true
            activityIndicator.startAnimating()
            overLayView.isHidden = false
        case .isSuccessful:
            activityIndicator.stopAnimating()
            retryButton.isHidden = true
            failedToConnectLabel.isHidden = true
            overLayView.isHidden = true
        case .isFailed:
            activityIndicator.stopAnimating()
            retryButton.isHidden = false
            failedToConnectLabel.isHidden = false
            overLayView.isHidden = false
        }
    }
    
    func createAndShowResultView() {
        self.performSegue(withIdentifier: resultSegue, sender: nil)
    }
    
    func setupQuizItemView() {
        
        if let vc = getUIViewControllerForID(identifier: QuizItemViewController.storyboardIdentifier) as? QuizItemViewController {
            addChildViewController(view: containerView, childVC: vc)
            
            vc.viewModel = viewModel.getQuizItemViewModel()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultVC = segue.destination as? ResultViewController {
            resultVC.viewModel = viewModel.getResultViweModel()
        }
    }

    func getUIViewControllerForID(identifier: String) -> UIViewController? {
        let sb = UIStoryboard(name: "Main", bundle: Bundle(for: QuizItemViewController.self))
        return sb.instantiateViewController(identifier: identifier)
    }
}

