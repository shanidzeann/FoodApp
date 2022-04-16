//
//  DatabaseManagerProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 15.04.2022.
//

import Foundation

protocol DatabaseManagerProtocol {
    func getItems() -> [CartItem]
    func addToDB(id: Int, title: String, description: String, price: Int, count: Int)
    func deleteFromDB(id: Int)
}
