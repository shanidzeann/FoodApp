//
//  LoginPresenterProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 03.05.2022.
//

import Foundation

protocol LoginPresenterProtocol {
    func authorize(_ user: FirebaseUser, completion: @escaping (String?) -> Void)
}
