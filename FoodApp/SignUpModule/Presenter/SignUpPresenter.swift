//
//  SignUpPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 07.06.2022.
//

import Foundation

class SignUpPresenter: SignUpPresenterProtocol {
    
    weak var view: SignUpViewProtocol?
    private var authManager: AuthManager!
    
    init(view: SignUpViewProtocol, authManager: AuthManager) {
        self.view = view
        self.authManager = authManager
    }
    
    
    func validateFields(user: FirebaseUser) throws {
        if isEmpty(user.name) ||
            isEmpty(user.phone) ||
            isEmpty(user.email) ||
            isEmpty(user.dateOfBirth) ||
            isEmpty(user.password) {
            throw RegisterError.emptyFields
        }
        
        if !isPasswordValid(user.password) {
            throw RegisterError.invalidPassword
        }
    }
    
    private func isEmpty(_ text: String) -> Bool {
        return text.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
    private func isPasswordValid(_ password: String) -> Bool {
        let cleanedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
        return passwordTest.evaluate(with: cleanedPassword)
    }
    
    func signUp() {
        
    }
    
}
//
//@objc private func didTapSignUp() {
//    do {
//        try validateFields()
//    } catch RegisterError.invalidPassword {
//        showError(RegisterError.invalidPassword.localizedDescription)
//    } catch RegisterError.emptyFields {
//        showError(RegisterError.emptyFields.localizedDescription)
//    } catch {
//        showError(error.localizedDescription)
//    }
//
//    let name = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//    let phone = phoneTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//    let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//    let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//    let dateOfBirth = dateOfBirthTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//    let user = FirebaseUser(name: name, email: email, phone: phone, password: password, dateOfBirth: dateOfBirth)
//
//    authManager.createUser(user) { error in
//        <#code#>
//    }
//
//}
//
//@objc private func cancelAction() {
//    dateOfBirthTextField.resignFirstResponder()
//}
//
//@objc private func doneAction() {
//    if let datePickerView = dateOfBirthTextField.inputView as? UIDatePicker {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy/MM/dd"
//        let dateString = dateFormatter.string(from: datePickerView.date)
//        dateOfBirthTextField.text = dateString
//
//        passwordTextField.becomeFirstResponder()
//    }
//}
