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
    
    var items: [CartItem]?
    
    // MARK: - Init
    
    required init(view: CartViewProtocol, databaseManager: DatabaseManagerProtocol) {
        self.view = view
        self.databaseManager = databaseManager
        getCart()
    }
    
    func getCart() {
        items = databaseManager.getItems()
    }
    
    func addToCart(_ item: CartItem) {
        databaseManager.addToDB(id: item.id, title: item.title, description: item.description, price: item.price, count: 1)
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func cartItem(for indexPath: IndexPath) -> CartItem? {
        return items?[indexPath.row]
    }
    
    
}

