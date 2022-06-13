//
//  OrderCellPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 13.06.2022.
//

import Foundation

class OrderCellPresenter: OrderCellPresenterProtocol {
    
    weak var view: OrderCellProtocol?
    
    required init(view: OrderCellProtocol) {
        self.view = view
    }
    
    func configure(with order: Order) {
        view?.setData(order: order)
    }
   
}
