//
//  CartPresenterProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 15.04.2022.
//

import Foundation

protocol CartPresenterProtocol {
    func addToCart(_ item: CartItem)
    func numberOfRowsInSection(_ section: Int) -> Int
    func getCart() 
    func cartItem(for indexPath: IndexPath) -> CartItem?
}
