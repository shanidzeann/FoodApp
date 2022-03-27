//
//  BannerViewController+UICollectionViewDelegateFlowLayout.swift
//  FoodApp
//
//  Created by Anna Shanidze on 28.03.2022.
//

import UIKit

extension BannerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.height - 20)
    }
}
