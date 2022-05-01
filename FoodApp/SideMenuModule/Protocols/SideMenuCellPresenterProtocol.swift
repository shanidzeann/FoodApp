//
//  SideMenuCellPresenterProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 01.05.2022.
//

import Foundation

protocol SideMenuCellPresenterProtocol {
    func cellText(at indexPath: IndexPath) -> String
    func cellImageName(at indexPath: IndexPath) -> String
}
