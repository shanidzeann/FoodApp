//
//  CheckoutViewController+CheckoutViewProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 14.06.2022.
//

import UIKit

extension CheckoutViewController: CheckoutViewProtocol {
    
    func setData(phone: String, username: String, totalPrice: String) {
        phoneTextField.text = phone
        nameTextField.text = username
        priceLabel.text = totalPrice
    }
    
    func closeOrder(with message: String) {
        show(message) { [weak self] in
            self?.presenter.emptyShoppingCart()
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}
