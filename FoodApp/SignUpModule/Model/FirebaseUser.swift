//
//  FirebaseUser.swift
//  FoodApp
//
//  Created by Anna Shanidze on 08.06.2022.
//

import Foundation

struct FirebaseUser {
    let name: String?
    let email: String
    let phone: String?
    let dateOfBirth: String?
    let password: String
    
    init(name: String? = nil,
         email: String,
         phone: String? = nil,
         dateOfBirth: String? = nil,
         password: String
    ) {
        self.name = name
        self.email = email
        self.phone = phone
        self.dateOfBirth = dateOfBirth
        self.password = password
    }
}
