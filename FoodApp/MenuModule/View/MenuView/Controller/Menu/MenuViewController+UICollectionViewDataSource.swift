//
//  MenuViewController+UICollectionViewDataSource.swift
//  FoodApp
//
//  Created by Anna Shanidze on 28.03.2022.
//

import UIKit

extension MenuViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let collectionViewType = CollectionViewType(rawValue: collectionView.tag) else { return 0 }
        switch collectionViewType {
        case .categories:
            return presenter.numberOfSections()
        case .menu:
            return presenter.numberOfItemsInSection(section)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let collectionViewType = CollectionViewType(rawValue: collectionView.tag) else { return 0 }
        switch collectionViewType {
        case .categories:
            return 1
        case .menu:
            return presenter.numberOfSections()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionViewType = CollectionViewType(rawValue: collectionView.tag) else { return UICollectionViewCell() }

        switch collectionViewType {
        case .categories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionView.CellIdentifiers.categoryCell, for: indexPath) as! CategoryCollectionViewCell
            let title = presenter.sectionTitle(for: indexPath.item)
            cell.configure(with: title)
            return  cell
        case .menu:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionView.CellIdentifiers.menuCell, for: indexPath) as! MenuCollectionViewCell
            
            let dbManager = DatabaseManager.shared
            if let item = presenter.menuItem(for: indexPath) {
                let cellPresenter = MenuCellPresenter(view: cell, databaseManager: dbManager, item: item)
                cell.inject(presenter: cellPresenter)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.CollectionView.Headers.menuHeader, for: indexPath) as? MenuHeaderSupplementaryView else {
            return UICollectionReusableView()
        }
        
        let title = presenter.sectionTitle(for: indexPath.section)
        headerView.configure(with: title)
        
        return headerView
    }
}
