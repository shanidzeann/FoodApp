//
//  CartViewProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 14.04.2022.
//

import Foundation

protocol CartViewProtocol: AnyObject {
    func configureCheckoutButton(title: String, isEnabled: Bool)
    func showEmptyCart()
    func showCart() 
}
