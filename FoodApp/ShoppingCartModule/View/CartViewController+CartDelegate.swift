//
//  CartViewController+CartDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 02.05.2022.
//

import Foundation

extension CartViewController: CartDelegate {
    func reloadData() {
        tableView.reloadData()
        presenter.checkCart()
    }
}
