//
//  OrderCellPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 13.06.2022.
//

import Foundation

final class OrderCellPresenter: OrderCellPresenterProtocol {
    
    weak var view: OrderCellProtocol?
    
    required init(view: OrderCellProtocol) {
        self.view = view
    }
    
    func configure(with order: Order) {
        view?.setData(order: order)
    }
   
    func stringFrom(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }
}
