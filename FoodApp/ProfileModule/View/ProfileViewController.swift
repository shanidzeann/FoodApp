//
//  ProfileViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 08.06.2022.
//


import UIKit
import SnapKit

class ProfileViewController: UIViewController, ProfileViewProtocol {
    
    // MARK: - Properties
    
    private var presenter: ProfilePresenterProtocol!
    
    // MARK: - UI
    
   
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        addSubviews()
        setupConstraints()
        setDelegates()
    }
    
    // MARK: - Injection
    
    func inject(_ presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - Private
    
    private func addSubviews() {
     
    }
    
    private func setupConstraints() {
    
    }
    
    private func setDelegates() {
    }
    
    // MARK: - Buttons
    
    private func configureButton(_ button: UIButton) {
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 7
        button.tintColor = .gray
    }
    
}
