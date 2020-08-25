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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func readArticleTapped(_ sender: Any) {
    }
    
    @IBAction func nextQuestionTapped(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
