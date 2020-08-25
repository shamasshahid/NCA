//
//  UIViewController+Extension.swift
//  News Quiz
//
//  Created by Shamas on 25/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addChildViewController(view: UIView, childVC: UIViewController) {
        view.addSubview(childVC.view)
        self.addChild(childVC)
        childVC.didMove(toParent: self)
    }
}
