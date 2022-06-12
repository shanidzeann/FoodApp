//
//  OrderHistoryPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 12.06.2022.
//

import Foundation

class OrderHistoryPresenter: OrderHistoryPresenterProtocol {
    
    weak var view: OrderHistoryViewProtocol?
    
    init(view: OrderHistoryViewProtocol) {
        self.view = view
    }
    
    
}
