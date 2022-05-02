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
    
    func checkCart() {
        if databaseManager.totalPrice == 0 {
            view?.configureCheckoutButton(title: "Корзина пуста", isEnabled: false)
            view?.showCart(isEmpty: true)
        } else {
            view?.configureCheckoutButton(title: "Оформить заказ на \(databaseManager.totalPrice) ₽", isEnabled: true)
            view?.showCart(isEmpty: false)
        }
        
    }

}

