//
//  OrderHistoryViewController+OrderHistoryViewProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 14.06.2022.
//

import Foundation

extension OrderHistoryViewController: OrderHistoryViewProtocol {
    func show(_ orders: [Order]) {
        ordersCollectionView?.reloadData()
    }
}
