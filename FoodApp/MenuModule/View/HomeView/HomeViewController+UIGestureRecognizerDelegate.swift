//
//  HomeViewController+UIGestureRecognizerDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 28.03.2022.
//

import UIKit

extension HomeViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let collectionView = gestureRecognizer.view as? UICollectionView,
              let collectionViewType = CollectionViewType(rawValue: collectionView.tag) else { return true }

        let recognizer = collectionView.panGestureRecognizer

        switch collectionViewType {
        case .categories:
            return abs((recognizer.velocity(in: recognizer.view)).y) > abs((recognizer.velocity(in: recognizer.view)).x)
        case .menu:
            if recognizer.velocity(in: recognizer.view).y > 0 {
                if collectionViewPanGestureEnabled && scrolledToTop {
                    return true
                }
                return false
            } else if recognizer.velocity(in: recognizer.view).y < 0 {
                if collectionViewPanGestureEnabled {
                    return false
                }
            }
        }
        return true
    }
    
    #warning("another solution?")
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
}
