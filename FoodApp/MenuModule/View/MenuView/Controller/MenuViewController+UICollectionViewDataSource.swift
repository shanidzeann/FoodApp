//
//  MenuViewController+UICollectionViewDataSource.swift
//  FoodApp
//
//  Created by Anna Shanidze on 28.03.2022.
//

import UIKit

extension MenuViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection(section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionView.CellIdentifiers.menuCell, for: indexPath) as! MenuCollectionViewCell
            
            let cellPresenter = MenuCellPresenter(view: cell)
            cell.inject(presenter: cellPresenter)
            
            if let item = presenter.menuItem(for: indexPath) {
                cell.configure(with: item)
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath)
            cell.backgroundColor = .red
            cell.clipsToBounds = true
            cell.layer.cornerRadius = cell.contentView.frame.height/2
            return  cell
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.CollectionView.Headers.menuHeader, for: indexPath) as? MenuHeaderSupplementaryView else {
            return UICollectionReusableView()
        }
        
        let headerPresenter = MenuHeaderPresenter(view: headerView)
        headerView.inject(presenter: headerPresenter)
        if let urlString = presenter.url(for: indexPath) {
            headerView.configure(with: urlString)
        }
        
        return headerView
    }
}
