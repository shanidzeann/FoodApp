//
//  AuthManagerProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 04.05.2022.
//

import Foundation

protocol AuthManagerProtocol {
    func createUser(_ user: FirebaseUser, completion: (String?) -> Void)
}
