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
            let indexPath = IndexPath(item: 0, section: indexPath.item)
            menuCollectionView?.scrollToItem(at: indexPath, at: .top, animated: true)
        }
    }
    
}
