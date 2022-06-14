//
//  MenuCellPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import Foundation

class MenuCellPresenter: MenuCellPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: MenuCellProtocol?
    var menuItem: MenuItem?
    var databaseManager: LocalDatabaseManagerProtocol!
    
    var title: String? {
        return menuItem?.title
    }
    
    var description: String? {
        return menuItem?.restaurantChain
    }
    
    var price: Int? {
        return (menuItem?.id ?? 0) / 1000
    }
    
    var id: Int? {
        return menuItem?.id
    }
    
    // MARK: - Init
    
    required init(view: MenuCellProtocol, databaseManager: LocalDatabaseManager) {
        self.view = view
        self.databaseManager = databaseManager
        print(databaseManager.totalPrice, databaseManager.items)
    }
    
    // MARK: - Methods
    
    func configure(with item: MenuItem) {
        menuItem = item
        guard let title = title, let description = description, let price = price else { return }

        let image = item.image
        let url = URL(string: image)
        let priceRub = "\(price) ₽"
        let subtitle = isInCart() ? "В корзине" : nil
        
        view?.setData(title: title, description: description, price: priceRub, imageURL: url, subtitle: subtitle)
    }
    
    func addToCart() {
        guard let menuItem = menuItem, let title = title, let description = description, let price = price else { return }
        databaseManager.addToDB(id: menuItem.id, title: title, description: description, price: price, imageUrl: menuItem.image, count: 1)
    }
    
    func deleteFromCart() {
        guard let menuItem = menuItem else { return }
        databaseManager.deleteFromDB(id: menuItem.id)
    }
    
    func isInCart() -> Bool {
        guard let id = id else { return false }
        return databaseManager.checkIfCartContains(id: id)
    }
}
