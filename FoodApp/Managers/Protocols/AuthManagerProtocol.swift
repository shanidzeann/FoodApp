//
//  AuthManagerProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 04.05.2022.
//

import Foundation
import FirebaseAuth

protocol AuthManagerProtocol {
    func create(_ user: FirebaseUser, completion: @escaping (String?) -> Void)
    func authorize(_ user: FirebaseUser, completion: @escaping (String?) -> Void)
}
