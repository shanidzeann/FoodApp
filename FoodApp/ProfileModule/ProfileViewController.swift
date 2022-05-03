//
//  ProfileViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 03.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    private var presenter: ProfilePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .red
    }
    
    func inject(_ presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
    }
    
}


extension ProfileViewController: ProfileViewProtocol {
    
}
