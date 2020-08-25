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
    }
    
    func createAndShowResultView() {
        self.performSegue(withIdentifier: resultSegue, sender: nil)
    }
    
    func setupQuizItemView() {
        
        if let vc = getUIViewControllerForID(identifier: QuizItemViewController.storyboardIdentifier) as? QuizItemViewController {
            containerView.addSubview(vc.view)
            addChild(vc)
            vc.didMove(toParent: self)
            
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

