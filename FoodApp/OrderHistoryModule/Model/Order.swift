//
//  Order.swift
//  FoodApp
//
//  Created by Anna Shanidze on 12.06.2022.
//

import Foundation

struct Order {
    var orderItems: [OrderItem]?
    var userID: String?
    let address: String
    let apartment: String
    let floor: String
    var date: Date?
    var totalPrice: Int?
    let userName: String
    let userPhone: String
}
