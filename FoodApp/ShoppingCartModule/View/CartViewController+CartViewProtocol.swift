//
//  CartViewController+CartViewProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 02.05.2022.
//

import Foundation

extension CartViewController: CartViewProtocol {
    func configureCheckoutButton(title: String, isEnabled: Bool) {
        checkoutButton.setTitle(title, for: .normal)
        checkoutButton.isEnabled = isEnabled
    }
    
    func showCart(isEmpty: Bool) {
        tableView.alpha = isEmpty ? 0 : 1
        emptyCartImageView.alpha = isEmpty ? 1 : 0
    }
}
