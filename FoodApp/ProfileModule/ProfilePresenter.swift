//
//  ProfilePresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 03.05.2022.
//

import Foundation

protocol ProfileViewProtocol: AnyObject {
    
}

protocol ProfilePresenterProtocol {
    
}

class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var view: ProfileViewProtocol?
    
    init(view: ProfileViewProtocol) {
        self.view = view
    }
}
