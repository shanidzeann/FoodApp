//
//  CartViewController+UITableViewDataSource.swift
//  FoodApp
//
//  Created by Anna Shanidze on 18.04.2022.
//

import UIKit

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableView.CellIdentifiers.cartCell, for: indexPath) as! CartTableViewCell
        
        if let item = presenter.cartItem(for: indexPath) {
            let databaseManager = DatabaseManager.shared
            let cellPresenter = CartCellPresenter(view: cell, databaseManager: databaseManager, item: item)
            cell.inject(presenter: cellPresenter, delegate: self)
        }
        
        return cell
    }
}
