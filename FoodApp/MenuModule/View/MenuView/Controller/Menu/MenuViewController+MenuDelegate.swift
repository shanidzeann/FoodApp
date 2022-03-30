//
//  MenuViewController+MenuDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 30.03.2022.
//

import Foundation

extension MenuViewController: MenuDelegate {
    func showCategory(at indexPath: IndexPath) {
        let menuIndexPath = IndexPath(item: 0, section: indexPath.row)
        menuCollectionView?.scrollToSupplementaryView(ofKind: Constants.CollectionView.Headers.elementKind, at: menuIndexPath, animated: true)
    }
}
