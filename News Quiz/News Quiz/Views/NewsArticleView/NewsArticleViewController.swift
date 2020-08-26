//
//  NewsArticleViewController.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import UIKit
import WebKit

/// `NewsArticleViewController` is a lightweight view that open a webview for the story
class NewsArticleViewController: UIViewController {

    var viewModel: NewsArticleViewModel!
    @IBOutlet weak var wkWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = viewModel.getNewsArticleURL() {
            let request = URLRequest(url: url)
            wkWebView.load(request)
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
