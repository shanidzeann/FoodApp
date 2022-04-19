//
//  SideMenuViewControllerDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 18.04.2022.
//

import Foundation

protocol SideMenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: MenuOptions)
}
