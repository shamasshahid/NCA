//
//  QuizItemViewController.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import UIKit
import Kingfisher

class QuestionViewController: UIViewController {

    static let storyboardIdentifier = "QuestionViewController"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    
    var viewModel: QuestionViewModel! {
        didSet {
            setupViewModel()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        [answerButton1, answerButton2, answerButton3].forEach { button in
            button?.titleLabel?.textAlignment = .center
            button?.layer.cornerRadius = 5
            button?.clipsToBounds = true
        }
    }
    
    func setupViewModel() {
        
        viewModel.onQuestionUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.updateView()
            }
        }
    }
    
    func updateView() {
        imageView.kf.setImage(with: viewModel.getImageURL())
        [answerButton1, answerButton2, answerButton3].forEach { (button) in
            button?.setTitle(viewModel.getOptionTitleFor(index: button?.tag ?? 0), for: .normal)
        }
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        viewModel.userSelectedAnswerIndex(index: sender.tag)
    }

}
