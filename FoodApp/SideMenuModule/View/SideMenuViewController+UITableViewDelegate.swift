//
//  SideMenuViewController+UITableViewDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 01.05.2022.
//

import UIKit

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = presenter.item(for: indexPath)
        delegate?.didSelect(menuItem: item)
    }
}
