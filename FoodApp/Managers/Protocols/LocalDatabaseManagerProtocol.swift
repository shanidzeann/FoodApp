//
//  LocalDatabaseManagerProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 15.04.2022.
//

import Foundation

protocol LocalDatabaseManagerProtocol {
    func getItems()
    func addToDB(id: Int, title: String, description: String, price: Int, imageUrl: String, count: Int)
    func deleteFromDB(id: Int)
    var items: [CartItem]? { get set }
    var totalPrice: Int { get set }
    func checkIfCartContains(id: Int) -> Bool
    func deleteAll()
}
