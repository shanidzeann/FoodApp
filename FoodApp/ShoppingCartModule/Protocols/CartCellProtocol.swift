//
//  CartCellProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 15.04.2022.
//

import Foundation

protocol CartCellProtocol: AnyObject {
    func setData(title: String, description: String, price: String, imageUrl: String, count: String)
    func reloadData()
}
