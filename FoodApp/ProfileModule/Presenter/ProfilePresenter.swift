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
        getUserData()
    }
    
    func getUserData() {
        authManager.getUserData { result in
            switch result {
            case .success(let user):
                self.view?.setUserData(user)
            case .failure(_):
                return
            }
        }
    }
    
    func numberOfRows() -> Int {
        return ProfileMenu.allCases.count
    }
    
    func itemForRow(at indexPath: IndexPath) -> ProfileMenu? {
        return ProfileMenu.allCases[indexPath.row]
    }
    
}
