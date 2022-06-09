//
//  ProfilePresenterProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 08.06.2022.
//

import Foundation

protocol ProfilePresenterProtocol {
    func numberOfRows() -> Int
    func itemForRow(at indexPath: IndexPath) -> ProfileMenu?
}
