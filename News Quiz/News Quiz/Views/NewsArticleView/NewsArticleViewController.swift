//
//  NewsArticleViewController.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import UIKit
import WebKit

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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
