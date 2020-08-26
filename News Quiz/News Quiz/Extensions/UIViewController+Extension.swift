//
//  UIViewController+Extension.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Instantiates `UIViewController`by its identifier from the storyboard.
    /// - Parameters:
    ///   - identifier: ViewController storyboard identifier
    ///   - type: Type is used to locate the current bundle, since we might not be in the main Bundle
    ///   - storyboadName: storyboard name (defauls to "Main")
    /// - Returns: Optional UIViewController
    static func instantiateFromStoryBoard(identifier: String, type: AnyClass, storyboadName: String = "Main") -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboadName, bundle: Bundle(for: type.self))
        guard let vc = storyboard.instantiateViewController(identifier: identifier) as? QuestionViewController else {
            return nil
        }
        return vc
    }
    
    /// Adds the ViewController to the given view space and its ViewController
    /// - Parameters:
    ///   - view: <#view description#>
    ///   - childVC: <#childVC description#>
    func addChildViewController(view: UIView, childVC: UIViewController) {
        view.addSubview(childVC.view)
        self.addChild(childVC)
        childVC.view.frame = view.bounds
        childVC.didMove(toParent: self)
    }
}
