//
//  OrderHistoryViewProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 12.06.2022.
//

import Foundation

protocol OrderHistoryViewProtocol: AnyObject {
    func show(_ orders: [Order])
}
