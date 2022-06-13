//
//  Order.swift
//  FoodApp
//
//  Created by Anna Shanidze on 12.06.2022.
//

import Foundation

struct Order {
    let menuItems: [CartItem]
    let userID: String
    let address: String
    let date: Date
    let totalPrice: Int
}
