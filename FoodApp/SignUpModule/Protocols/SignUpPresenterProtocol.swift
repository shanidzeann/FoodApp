//
//  SignUpPresenterProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 02.06.2022.
//

import Foundation

protocol SignUpPresenterProtocol {
    func register(_ user: FirebaseUser, completion: @escaping (String?) -> Void)
    func stringFrom(_ date: Date) -> String
}
