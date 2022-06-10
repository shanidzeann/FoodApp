//
//  MenuViewController+UIViewControllerTransitioningDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 29.03.2022.
//

import UIKit

extension MenuViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
