//
//  ContainerViewController+UIGestureRecognizerDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 22.04.2022.
//

import UIKit

extension ContainerViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        switch sideMenuState {
        case .opened:
            return true
        case .closed:
            return false
        }
    }
}
