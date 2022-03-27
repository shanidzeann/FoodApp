//
//  BannerViewController+UICollectionViewDataSource.swift
//  FoodApp
//
//  Created by Anna Shanidze on 28.03.2022.
//

import UIKit

extension BannerViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionView.CellIdentifiers.bannerCell, for: indexPath) as! BannerCollectionViewCell
        
        return cell
    }
}
