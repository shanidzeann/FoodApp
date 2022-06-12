//
//  CartPresenterProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 15.04.2022.
//

import Foundation

protocol CartPresenterProtocol {
    func numberOfRowsInSection(_ section: Int) -> Int
    func cartItem(for indexPath: IndexPath) -> CartItem?
    func checkCart()
    func checkout()
}
