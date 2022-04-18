//
//  CartPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 14.04.2022.
//

import Foundation

class CartPresenter: CartPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: CartViewProtocol?
    var databaseManager: DatabaseManagerProtocol!
    
    // MARK: - Init
    
    required init(view: CartViewProtocol, databaseManager: DatabaseManagerProtocol) {
        self.view = view
        self.databaseManager = databaseManager
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return databaseManager.items?.count ?? 0
    }
    
    func cartItem(for indexPath: IndexPath) -> CartItem? {
        return databaseManager.items?[indexPath.row]
    }
    
    func checkoutButton() -> (title: String, isEnabled: Bool) {
        if databaseManager.totalPrice == 0 {
            return ("Корзина пуста", false)
        } else {
            return ("Оформить заказ на \(databaseManager.totalPrice)", true)
        }
    }
    
    
}

