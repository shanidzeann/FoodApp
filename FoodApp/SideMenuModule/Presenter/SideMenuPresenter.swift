//
//  SideMenuPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 18.04.2022.
//

import Foundation

class SideMenuPresenter: SideMenuPresenterProtocol {
    
    // MARK: - Helper Methods
    
    func numberOfRowsInSection() -> Int {
        return MenuOptions.allCases.count
    }
    
    func item(for indexPath: IndexPath) -> MenuOptions {
        return MenuOptions.allCases[indexPath.row]
    }
    
    // создать презентер для ячейки?
    func cellText(at indexPath: IndexPath) -> String {
        return MenuOptions.allCases[indexPath.row].rawValue
    }
    
    func cellImageName(at indexPath: IndexPath) -> String {
        return MenuOptions.allCases[indexPath.row].imageName
    }
    
}
