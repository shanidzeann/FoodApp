//
//  MenuCellPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import Foundation

class MenuCellPresenter: MenuCellPresenterProtocol {
    
    weak var view: MenuCellProtocol?
    var menuItem: MenuItem?
    var databaseManager: DatabaseManagerProtocol!
    
    var title: String? {
        return menuItem?.title
    }
    
    var description: String? {
        return menuItem?.restaurantChain
    }
    
    var price: Int? {
        return (menuItem?.id ?? 0) / 1000
    }
    
    required init(view: MenuCellProtocol, databaseManager: DatabaseManager, item: MenuItem) {
        self.view = view
        self.databaseManager = databaseManager
        self.menuItem = item
        configure(with: item)
    }
    
    func configure(with item: MenuItem) {
        guard let title = title, let description = description, let price = price else { return }

        let image = item.image
        let url = URL(string: image)
        
        view?.setData(title: title, description: description, price: price, imageURL: url)
    }
    
    func addToCart() {
        guard let menuItem = menuItem, let title = title, let description = description, let price = price else { return }
        databaseManager.addToDB(id: menuItem.id, title: title, description: description, price: price, count: 1)
        view?.reloadData()
    }
    
    func deleteFromCart() {
        guard let menuItem = menuItem else { return }
        databaseManager.deleteFromDB(id: menuItem.id)
        view?.reloadData()
    }
}
