//
//  DeliveryViewController+UIViewControllerTransitioningDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.04.2022.
//

import UIKit

extension DeliveryViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        DeliveryTermsPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
