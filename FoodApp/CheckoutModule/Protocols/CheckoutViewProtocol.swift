//
//  CheckoutViewProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 13.06.2022.
//

import Foundation

protocol CheckoutViewProtocol: AnyObject {
    func closeOrder(with message: String)
    func show(_ message: String, completion: (() -> Void)?)
    func setData(phone: String, username: String, totalPrice: String)
}

extension CheckoutViewProtocol {
    func show(_ message: String) {
        show(message, completion: nil)
    }
}
