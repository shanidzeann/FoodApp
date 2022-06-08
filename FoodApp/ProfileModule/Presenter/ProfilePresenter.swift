//
//  ProfilePresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 08.06.2022.
//

import Foundation

class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var view: ProfileViewProtocol?
    private var authManager: AuthManagerProtocol!
    
    init(view: ProfileViewProtocol, authManager: AuthManagerProtocol) {
        self.view = view
        self.authManager = authManager
    }
    
}
