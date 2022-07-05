//
//  SideMenuPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 18.04.2022.
//

import Foundation

final class SideMenuPresenter: SideMenuPresenterProtocol {
    
    func numberOfRowsInSection() -> Int {
        return MenuOptions.allCases.count
    }
    
    func item(for indexPath: IndexPath) -> MenuOptions {
        return MenuOptions.allCases[indexPath.row]
    }
    
}
