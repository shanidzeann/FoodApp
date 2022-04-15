//
//  CartPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 14.04.2022.
//

import Foundation

protocol CartPresenterProtocol {
    func addToCart(_ item: Item)
    func numberOfRowsInSection(_ section: Int) -> Int
}

class CartPresenter: CartPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: CartViewProtocol?
    var databaseManager: DatabaseManagerProtocol!
    
    var items: [Item]?
    
    // MARK: - Init
    
    required init(view: CartViewProtocol, databaseManager: DatabaseManagerProtocol) {
        self.view = view
        self.databaseManager = databaseManager
        getCart()
    }
    
    private func getCart() {
        items = databaseManager.getItems()
    }
    
    func addToCart(_ item: Item) {
        databaseManager.addToDB(title: item.title, description: item.description, price: item.price)
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return items?.count ?? 0
    }
    
    
}
