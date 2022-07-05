//
//  OrderHistoryPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 12.06.2022.
//

import Foundation

final class OrderHistoryPresenter: OrderHistoryPresenterProtocol {
    
    weak var view: OrderHistoryViewProtocol?
    private var firestoreManager: FirestoreManagerProtocol!
    private var orders: [Order]?
    
    init(view: OrderHistoryViewProtocol, firestoreManager: FirestoreManagerProtocol) {
        self.view = view
        self.firestoreManager = firestoreManager
    }
    
    func getUserOrders() {
        firestoreManager.getUserOrders { result in
            switch result {
            case .success(let orders):
                self.orders = orders
                self.view?.show(orders)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfItems() -> Int {
        return orders?.count ?? 0
    }
    
    func order(for indexPath: IndexPath) -> Order? {
        return orders?[indexPath.item]
    }
    
}
