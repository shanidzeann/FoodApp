//
//  ProfileViewController+ProfileViewProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 09.06.2022.
//

import Foundation

extension ProfileViewController: ProfileViewProtocol {
    func setUserData(_ user: FirebaseUser) {
        nameLabel.text = user.name
        phoneLabel.text = user.phone
        emailLabel.text = user.email
    }
}
