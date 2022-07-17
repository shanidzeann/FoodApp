//
//  ContainerPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 17.07.2022.
//

import Foundation
import FirebaseAuth

class ContainerPresenter: ContainerPresenterProtocol {
    
    weak var view: ContainerViewProtocol?
    var authManager: AuthManagerProtocol
    
    var currentUser: User? {
        authManager.currentUser
    }
    
    init(view: ContainerViewProtocol, authManager: AuthManagerProtocol) {
        self.view = view
        self.authManager = authManager
    }
    
    func isUserAuthenticated() -> Bool {
        currentUser != nil
    }
    
}
