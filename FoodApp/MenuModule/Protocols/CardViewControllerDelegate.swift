//
//  CardViewControllerDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 30.03.2022.
//

import Foundation

protocol CardViewControllerDelegate: AnyObject {
    func showCategory(at indexPath: IndexPath)
}
