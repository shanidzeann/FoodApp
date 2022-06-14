//
//  CheckoutPresenterProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 13.06.2022.
//

import Foundation

protocol CheckoutPresenterProtocol {
    func getData()
    func check(_ address: String, completion: @escaping (Bool, String) -> Void)
    func checkout(_ order: Order)
    func emptyShoppingCart()
}
