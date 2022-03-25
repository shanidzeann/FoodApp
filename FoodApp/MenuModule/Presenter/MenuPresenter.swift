//
//  MenuPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import Foundation


class MenuPresenter: MenuPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: MenuViewProtocol?
    
    // MARK: - Init
    
    required init(view: MenuViewProtocol) {
        self.view = view
    }
    
    // MARK: - Helper Methods
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return 10
    }
    
    func numberOfSections() -> Int {
        return 2
    }
    
}
