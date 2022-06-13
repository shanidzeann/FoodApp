//
//  OrderHistoryPresenterProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 12.06.2022.
//

import Foundation

protocol OrderHistoryPresenterProtocol {
    func getUserOrders()
    func numberOfItems() -> Int
    func order(for indexPath: IndexPath) -> Order?
}
