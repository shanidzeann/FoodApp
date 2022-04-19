//
//  MenuCellProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import Foundation

protocol MenuCellProtocol: AnyObject {
    func setData(title: String, description: String, price: String, imageURL: URL?, subtitle: String?)
}
