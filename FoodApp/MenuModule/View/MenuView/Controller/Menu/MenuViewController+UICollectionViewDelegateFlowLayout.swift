//
//  MenuViewController+UICollectionViewDelegateFlowLayout.swift
//  FoodApp
//
//  Created by Anna Shanidze on 29.03.2022.
//

import UIKit

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: presenter.sections[indexPath.item].title.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width + 25, height: 35)
    }
}
