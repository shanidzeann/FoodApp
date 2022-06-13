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
    var localDatabaseManager: LocalDatabaseManagerProtocol!
    var firestoreManager: FirestoreManagerProtocol!
    
    // MARK: - Init
    
    required init(view: CartViewProtocol,
                  localDatabaseManager: LocalDatabaseManagerProtocol,
                  firestoreManager: FirestoreManagerProtocol) {
        self.view = view
        self.localDatabaseManager = localDatabaseManager
        self.firestoreManager = firestoreManager
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return localDatabaseManager.items?.count ?? 0
    }
    
    func cartItem(for indexPath: IndexPath) -> CartItem? {
        return localDatabaseManager.items?[indexPath.row]
    }
    
    func checkCart() {
        if localDatabaseManager.totalPrice == 0 {
            view?.configureCheckoutButton(title: "Корзина пуста", isEnabled: false)
            view?.showCart(isEmpty: true)
        } else {
            view?.configureCheckoutButton(title: "Оформить заказ на \(localDatabaseManager.totalPrice) ₽", isEnabled: true)
            view?.showCart(isEmpty: false)
        }
        
    }
    
    func checkout(completion: (String) -> Void) {
        if firestoreManager.currentUser() != nil {
            firestoreManager.createOrder(with: localDatabaseManager.items!, totalPrice: localDatabaseManager.totalPrice)
            completion("Заказ оформлен успешно")
        } else {
            completion("Авторизуйтесь перед оформлением заказа")
        }
    }

}

