//
//  SideMenuCellPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 01.05.2022.
//

import Foundation

final class SideMenuCellPresenter: SideMenuCellPresenterProtocol {
    
    func cellText(at indexPath: IndexPath) -> String {
        return MenuOptions.allCases[indexPath.row].rawValue
    }
    
    func cellImageName(at indexPath: IndexPath) -> String {
        return MenuOptions.allCases[indexPath.row].imageName
    }
    
}
