//
//  MenuViewController+UIScrollViewDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 28.03.2022.
//

import UIKit

extension MenuViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.bounds.minY == 0, let collectionView = scrollView as? UICollectionView, collectionView.tag == 1 {
            NotificationCenter.default.post(name: NSNotification.Name("enableHomePanGestureRecognizer"), object: nil)
        }
    }
}
