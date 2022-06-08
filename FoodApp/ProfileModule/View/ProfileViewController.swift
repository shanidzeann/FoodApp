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
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Login"
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .next
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        return textField
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton(configuration: .filled(), primaryAction: nil)
        button.configuration?.baseBackgroundColor = .systemGreen
        button.setTitle("Log In", for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let resetPasswordButton: UIButton = {
        let button = UIButton(configuration: .plain(), primaryAction: nil)
        button.setTitle("Reset Password", for: .normal)
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(configuration: .plain(), primaryAction: nil)
        button.setTitle("Sign Up", for: .normal)
        return button
    }()
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
        configureButton(resetPasswordButton)
        configureButton(signUpButton)
        addTargets()
        setDelegates()
    }
    
    // MARK: - Injection
    
    func inject(_ presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - Private
    
    private func addSubviews() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(logInButton)
        view.addSubview(signUpButton)
        view.addSubview(resetPasswordButton)
    }
    
    private func setupConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        resetPasswordButton.snp.makeConstraints { make in
            make.bottom.equalTo(signUpButton.snp.top).inset(-10)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
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
    
    private func addTargets() {
        logInButton.addTarget(self, action: #selector(didTapLogIn), for: .touchUpInside)
        resetPasswordButton.addTarget(self, action: #selector(didTapResetPassword), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
    
    @objc private func didTapLogIn() {
        print("didTapLogIn")
    }
    
    @objc private func didTapResetPassword() {
        print("didTapResetPassword")
    }
    
    @objc private func didTapSignUp() {
    }
    
}
