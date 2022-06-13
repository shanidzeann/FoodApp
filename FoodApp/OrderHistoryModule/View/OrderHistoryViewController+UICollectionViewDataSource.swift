//
//  OrderHistoryViewController+UICollectionViewDataSource.swift
//  FoodApp
//
//  Created by Anna Shanidze on 13.06.2022.
//

import UIKit

extension OrderHistoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionView.CellIdentifiers.orderCell, for: indexPath) as! OrderCollectionViewCell
        
        if let order = presenter.order(for: indexPath) {
            let presenter = OrderCellPresenter(view: cell)
            cell.inject(presenter)
            presenter.configure(with: order)
        }
        
        return cell
    }
}
