//
//  HomeViewController+UIGestureRecognizerDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 28.03.2022.
//

import UIKit

extension HomeViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if let collectionView = gestureRecognizer.view as? UICollectionView, collectionView.tag == 2 {
            let recognizer = collectionView.panGestureRecognizer
            return abs((recognizer.velocity(in: recognizer.view)).y) > abs((recognizer.velocity(in: recognizer.view)).x)
            
        } else if let collectionView = gestureRecognizer.view as? UICollectionView, collectionView.tag == 1 {
            if collectionView.panGestureRecognizer.velocity(in: collectionView.panGestureRecognizer.view).y > 0 {
                if gestureEnabled && scrolledToTop {
                    return true
                }
                return false
                
            } else if collectionView.panGestureRecognizer.velocity(in: collectionView.panGestureRecognizer.view).y < 0 {
                if gestureEnabled {
                    return false
                }
            }
        }
        return true
    }
}
