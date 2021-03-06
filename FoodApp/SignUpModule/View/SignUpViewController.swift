//
//  SignUpViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 02.06.2022.
//

import UIKit

final class SignUpViewController: UIViewController, SignUpViewProtocol {
    
    // MARK: - Properties
    
    private var presenter: SignUpPresenterProtocol!
    
    // MARK: - UI
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя"
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .next
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .next
        return textField
    }()
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Телефон"
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .next
        return textField
    }()
    
    let dateOfBirthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Дата рождения"
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .next
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        textField.autocapitalizationType = .none
        textField.textContentType = .newPassword
        return textField
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
    
    private let signUpButton: UIButton = {
        let button = UIButton(configuration: .filled(), primaryAction: nil)
        button.configuration?.baseBackgroundColor = .systemGreen
        button.setTitle("Зарегистрироваться", for: .normal)
        button.tintColor = .white
        return button
    }()
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        dateOfBirthTextField.datePicker(target: self,
                                        doneAction: #selector(doneAction),
                                        cancelAction: #selector(cancelAction),
                                        datePickerMode: .date)
        
        addSubviews()
        setupConstraints()
        configureButton(signUpButton)
        addTargets()
        setDelegates()
    }
    
    // MARK: - Injection
    
    func inject(_ presenter: SignUpPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - Private
    
    private func addSubviews() {
        view.addSubview(userImageView)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(phoneTextField)
        view.addSubview(dateOfBirthTextField)
        view.addSubview(passwordTextField)
        view.addSubview(errorLabel)
        view.addSubview(signUpButton)
    }
    
    private func setupConstraints() {
        userImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(70)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(10)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        dateOfBirthTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(10)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(dateOfBirthTextField.snp.bottom).offset(10)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
    }
    
    private func setDelegates() {
        nameTextField.delegate = self
        emailTextField.delegate = self
        phoneTextField.delegate = self
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
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
    
    @objc private func didTapSignUp() {
        presenter.register(user()) { error in
            if error != nil {
                self.showError(error!)
            } else {
                self.dismiss()
            }
        }
    }
    
    private func user() -> FirebaseUser {
        let name = nameTextField.text!
        let phone = phoneTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let dateOfBirth = dateOfBirthTextField.text!
        return FirebaseUser(name: name, email: email, phone: phone, dateOfBirth: dateOfBirth, password: password)
    }
    
    private func dismiss() {
        let alert = UIAlertController(title: "Вы были успешно зарегистрированы",
                                      message: "Для входа в личный кабинет введите свои данные на странице авторизации",
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ок", style: .cancel) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @objc private func cancelAction() {
        dateOfBirthTextField.resignFirstResponder()
    }
    
    @objc private func doneAction() {
        if let datePickerView = dateOfBirthTextField.inputView as? UIDatePicker {
            dateOfBirthTextField.text = presenter.stringFrom(datePickerView.date)
            passwordTextField.becomeFirstResponder()
        }
    }
    
    // MARK: - Errors
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
}
