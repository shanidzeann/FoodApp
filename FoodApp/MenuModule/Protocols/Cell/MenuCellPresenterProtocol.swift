//
//  MenuCellPresenterProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import Foundation

protocol MenuCellPresenterProtocol {
    func configure(with item: MenuItem)
    func addToCart()
    func deleteFromCart()
}
