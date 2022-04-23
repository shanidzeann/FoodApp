//
//  SideMenuState.swift
//  FoodApp
//
//  Created by Anna Shanidze on 19.04.2022.
//

import Foundation

enum SideMenuState {
    case opened
    case closed
    
    mutating func toggle() {
        switch self {
        case .opened:
            self = .closed
        case .closed:
            self = .opened
        }
    }
}
