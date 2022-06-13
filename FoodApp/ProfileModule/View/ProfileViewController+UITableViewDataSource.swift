//
//  ProfileViewController+UITableViewDataSource.swift
//  FoodApp
//
//  Created by Anna Shanidze on 08.06.2022.
//

import UIKit

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableView.CellIdentifiers.cell, for: indexPath)
        
        cell.backgroundColor = .clear
        cell.imageView?.tintColor = .black
        if let item = presenter.itemForRow(at: indexPath) {
            cell.imageView?.image = UIImage(systemName: item.image)
            cell.textLabel?.text = item.rawValue
        }
        
        return cell
    }
}
