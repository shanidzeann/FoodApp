//
//  Constants.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import Foundation

enum Constants {
    enum CollectionView {
        enum CellIdentifiers {
            static let menuCell = "menuCell"
            static let bannerCell = "bannerCell"
            static let categoryCell = "categoryCell"
            static let orderCell = "orderCell"
        }
        
        enum Headers {
            static let elementKind = "header"
            static let menuHeader = "menuHeaderView"
        }
    }
    
    enum TableView {
        enum CellIdentifiers {
            static let cell = "cell"
            static let cartCell = "cartCell"
            static let cardCell = "cardCell"
            static let sideMenuCell = "sideMenuCell"
        }
    }
    
}
