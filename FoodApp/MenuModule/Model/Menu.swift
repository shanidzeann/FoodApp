//
//  Menu.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import Foundation

// MARK: - Menu
struct Menu: Codable {
    let type: String
    let menuItems: [MenuItem]
    let offset, number, totalMenuItems, processingTimeMS: Int
    let expires: Int
    let isStale: Bool?

    enum CodingKeys: String, CodingKey {
        case type, menuItems, offset, number, totalMenuItems
        case processingTimeMS = "processingTimeMs"
        case expires, isStale
    }
}

// MARK: - MenuItem
struct MenuItem: Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: ImageType
    let restaurantChain: String
    let servingSize, readableServingSize: String?
    let servings: Servings
}

enum ImageType: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
    case png = "png"
}

// MARK: - Servings
struct Servings: Codable {
    let number: Int
    let size: Int?
    let unit: String?
}


