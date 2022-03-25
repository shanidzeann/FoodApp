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
    
//    func configure(item: ) {

//    }
    
}
