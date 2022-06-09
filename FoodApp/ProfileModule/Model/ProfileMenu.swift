//
//  ProfileMenu.swift
//  FoodApp
//
//  Created by Anna Shanidze on 08.06.2022.
//

import Foundation

enum ProfileMenu: String, CaseIterable {
    case orders = "История заказов"
    case exit = "Выйти"
    
    var image: String {
        switch self {
        case .orders: return "menucard"
        case .exit: return "person.fill.xmark"
        }
    }
}
