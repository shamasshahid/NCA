//
//  QuizItemViewController.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import UIKit
import Kingfisher

class QuizItemViewController: UIViewController {

    static let storyboardIdentifier = "QuizItemViewController"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    
    var viewModel: QuizItemViewModel! {
        didSet {
            setupViewModel()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViewModel() {
        
        viewModel.onViewRefreshed = { [weak self] in
            DispatchQueue.main.async {
                self?.imageView.kf.setImage(with: self?.viewModel.getImageURL())
                [self?.answerButton1, self?.answerButton2, self?.answerButton3].forEach { button in
                    button?.setTitle(self?.viewModel.getOptionTitleFor(index: button?.tag ?? 0) ?? "---", for: .normal)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        viewModel.userSelectedAnswerIndex(index: sender.tag)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
