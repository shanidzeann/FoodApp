//
//  ProfileViewProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 08.06.2022.
//

import Foundation

protocol ProfileViewProtocol: AnyObject {
    func setUserData(_ user: FirebaseUser)
}
