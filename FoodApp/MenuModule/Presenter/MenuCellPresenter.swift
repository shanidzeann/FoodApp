//
//  MenuCellPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import Foundation

class MenuCellPresenter: MenuCellPresenterProtocol {
    
    weak var view: MenuCellProtocol?
    
    required init(view: MenuCellProtocol) {
        self.view = view
    }
    
    func configure(with item: MenuItem) {
        let title = item.title
        let description = item.restaurantChain
        let price = item.id / 1000
        
        let image = item.image
        let url = URL(string: image)
        
        view?.setData(title: title, description: description, price: price, imageURL: url)
    }
    
}
