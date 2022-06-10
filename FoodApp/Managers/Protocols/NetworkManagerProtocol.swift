//
//  NetworkManagerProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    func downloadMenu(completion: @escaping ([Result<(url: String, menu: Menu), Error>]) -> Void)
}
