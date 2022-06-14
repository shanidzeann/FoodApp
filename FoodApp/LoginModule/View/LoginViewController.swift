//
//  LoginViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 03.05.2022.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private var presenter: LoginPresenterProtocol!
    
    // MARK: - UI
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = .systemGray
        return imageView
    }()
    
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
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.alpha = 0
        label.textAlignment = .center
        return label
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
    
    func inject(_ presenter: LoginPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - Private
    
    private func addSubviews() {
        view.addSubview(userImageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(logInButton)
        view.addSubview(signUpButton)
        view.addSubview(resetPasswordButton)
        view.addSubview(errorLabel)
    }
    
    private func setupConstraints() {
        userImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(70)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(10)
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
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(logInButton.snp.bottom).offset(10)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        
        resetPasswordButton.snp.makeConstraints { make in
            make.bottom.equalTo(signUpButton.snp.top).inset(-10)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }
    
    private func setDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func configureButton(_ button: UIButton) {
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 7
        button.tintColor = .gray
    }
    
    // MARK: - Actions
    
    private func addTargets() {
        logInButton.addTarget(self, action: #selector(didTapLogIn), for: .touchUpInside)
        resetPasswordButton.addTarget(self, action: #selector(didTapResetPassword), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
    
    @objc func didTapLogIn() {
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let user = FirebaseUser(email: email, password: password)
        
        presenter.authorize(user) { [weak self] error in
            if error != nil {
                self?.showError(error!)
            } else {
                NotificationCenter.default.post(name: NSNotification.Name("showProfile"), object: nil)
            }
        }
    }
    
    @objc private func didTapResetPassword() {
        print("didTapResetPassword")
    }
    
    @objc private func didTapSignUp() {
        let signUpVC = SignUpViewController()
        let dbManager = FirestoreManager()
        let authManager = AuthManager(databaseManager: dbManager)
        let signUpPresenter = SignUpPresenter(view: signUpVC, authManager: authManager)
        signUpVC.inject(signUpPresenter)
        present(signUpVC, animated: true)
    }
    
    // MARK: - Errors
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
}
