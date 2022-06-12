//
//  MenuOptions.swift
//  FoodApp
//
//  Created by Anna Shanidze on 18.04.2022.
//

import Foundation

enum MenuOptions: String, CaseIterable {
    case home = "Меню"
    case profile = "Профиль"
    case delivery = "Доставка"
    
    var imageName: String {
        switch self {
        case .home:
            return "menucard"
        case .profile:
            return "person.crop.circle"
        case .delivery:
            return "scooter"
        }
    }
}
