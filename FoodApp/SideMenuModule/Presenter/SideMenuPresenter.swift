//
//  SideMenuPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 18.04.2022.
//

import Foundation

class SideMenuPresenter: SideMenuPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: SideMenuViewProtocol?
    
    // MARK: - Init
    
    required init(view: SideMenuViewProtocol) {
        self.view = view
    }
    
    // MARK: - Helper Methods
    
    func numberOfRowsInSection() -> Int {
        return MenuOptions.allCases.count
    }
    
    // создать презентер для ячейки?
    func cellText(at indexPath: IndexPath) -> String {
        return MenuOptions.allCases[indexPath.row].rawValue
    }
    
    func cellImageName(at indexPath: IndexPath) -> String {
        return MenuOptions.allCases[indexPath.row].imageName
    }
    
    func item(for indexPath: IndexPath) -> MenuOptions {
        return MenuOptions.allCases[indexPath.row]
    }
    
}
