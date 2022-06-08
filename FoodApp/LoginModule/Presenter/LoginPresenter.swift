//
//  ProfilePresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 03.05.2022.
//

import Foundation

class LoginPresenter: LoginPresenterProtocol {
    
    weak var view: LoginViewProtocol?
    private var authManager: AuthManagerProtocol!
    
    init(view: LoginViewProtocol, authManager: AuthManagerProtocol) {
        self.view = view
        self.authManager = authManager
    }
    
    func authorize(_ user: FirebaseUser, completion: @escaping (String?) -> Void) {
        authManager.authorize(user) { error in
            completion(error)
        }
    }
}
