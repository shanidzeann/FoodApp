//
//  OrderHistoryViewController+UICollectionViewDelegateFlowLayout.swift
//  FoodApp
//
//  Created by Anna Shanidze on 13.06.2022.
//

import UIKit

extension OrderHistoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 70)
    }
}
