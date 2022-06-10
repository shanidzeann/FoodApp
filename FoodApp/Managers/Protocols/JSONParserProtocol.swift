//
//  JSONParserProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 22.04.2022.
//

import Foundation

protocol JSONParserProtocol {
    func parseJSON<T: Decodable>(data: Data, completion: @escaping (Result<T, Error>) -> Void)
}
