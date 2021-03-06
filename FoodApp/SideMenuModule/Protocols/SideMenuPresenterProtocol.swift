//
//  SideMenuPresenterProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 18.04.2022.
//

import Foundation

protocol SideMenuPresenterProtocol {
    func numberOfRowsInSection() -> Int
    func item(for indexPath: IndexPath) -> MenuOptions
}
