//
//  OrderCellPresenterProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 13.06.2022.
//

import Foundation

protocol OrderCellPresenterProtocol {
    func configure(with order: Order)
    func stringFrom(_ date: Date) -> String
}
