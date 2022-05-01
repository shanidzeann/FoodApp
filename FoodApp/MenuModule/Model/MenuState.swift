//
//  MenuState.swift
//  FoodApp
//
//  Created by Anna Shanidze on 01.05.2022.
//

import Foundation

enum MenuState {
    case expanded
    case collapsed
    
    mutating func toggle() {
        switch self {
        case .expanded:
            self = .collapsed
        case .collapsed:
            self = .expanded
        }
    }
}
