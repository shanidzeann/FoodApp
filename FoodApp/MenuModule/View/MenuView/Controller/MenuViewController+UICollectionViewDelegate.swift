//
//  MenuViewController+UICollectionViewDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 28.03.2022.
//

import UIKit

extension MenuViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collectionViewType = CollectionViewType(rawValue: collectionView.tag)
        
        if collectionViewType == .categories {
            NotificationCenter.default.post(name: NSNotification.Name("animateTransitionIfNeeded"), object: nil)
            let indexPath = IndexPath(item: 0, section: indexPath.item)
            menuCollectionView?.scrollToSupplementaryView(ofKind: Constants.CollectionView.Headers.elementKind, at: indexPath, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        let collectionViewType = CollectionViewType(rawValue: collectionView.tag)
        
        if collectionViewType == .menu {
            categoriesCollectionView?.scrollToItem(at: IndexPath(item: indexPath.section, section: 0), at: [.centeredVertically, .left], animated: true)
        }
    }
}
