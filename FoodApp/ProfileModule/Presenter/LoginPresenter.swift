//
//  ProfilePresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 03.05.2022.
//

import Foundation

class LoginPresenter: LoginPresenterProtocol {
    
    weak var view: LoginViewProtocol?
    
    init(view: LoginViewProtocol) {
        self.view = view
    }
}
