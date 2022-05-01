//
//  SideMenuViewController+UITableViewDataSource.swift
//  FoodApp
//
//  Created by Anna Shanidze on 01.05.2022.
//

import UIKit

extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableView.CellIdentifiers.sideMenuCell, for: indexPath)
        let cellPresenter = SideMenuCellPresenter()
        cell.textLabel?.text = cellPresenter.cellText(at: indexPath)
        cell.textLabel?.textColor = .black
        cell.imageView?.image = UIImage(systemName: cellPresenter.cellImageName(at: indexPath))
        cell.imageView?.tintColor = .black
        return cell
    }
}
