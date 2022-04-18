//
//  CartCellPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 15.04.2022.
//

import Foundation

class CartCellPresenter: CartCellPresenterProtocol {
    
    weak var view: CartCellProtocol?
    var cartItem: CartItem?
    var databaseManager: DatabaseManagerProtocol!
    
    required init(view: CartCellProtocol, databaseManager: DatabaseManager, item: CartItem) {
        self.view = view
        self.databaseManager = databaseManager
        self.cartItem = item
        configure()
    }
    
    func addToCart() {
        guard let cartItem = cartItem else { return }
        databaseManager.addToDB(id: cartItem.id, title: cartItem.title, description: cartItem.description, price: cartItem.price, imageUrl: cartItem.imageUrl, count: 0)
        view?.reloadData()
    }
    
    func deleteFromCart() {
        guard let cartItem = cartItem else { return }
        databaseManager.deleteFromDB(id: cartItem.id)
        view?.reloadData()
    }
    
    func configure() {
        guard let cartItem = cartItem else { return }
        let title = cartItem.title
        let description = cartItem.description
        let price = String(cartItem.price)
        let count = String(cartItem.count)
        let imageUrl = cartItem.imageUrl

        view?.setData(title: title, description: description, price: price, imageUrl: imageUrl, count: count)
    }
}
