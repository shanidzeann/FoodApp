//
//  SignUpPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 07.06.2022.
//

import Foundation

class SignUpPresenter: SignUpPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: SignUpViewProtocol?
    private var authManager: AuthManager!
    
    // MARK: - Init
    
    init(view: SignUpViewProtocol, authManager: AuthManager) {
        self.view = view
        self.authManager = authManager
    }
    
    // MARK: - Registration
    
    func register(_ user: FirebaseUser, completion: @escaping (String?) -> Void) {
        do {
            try validateFields(with: user)
            authManager.create(user) { error in
                completion(error)
            }
        } catch RegisterError.invalidPassword {
            completion(RegisterError.invalidPassword.localizedDescription)
        } catch RegisterError.emptyFields {
            completion(RegisterError.emptyFields.localizedDescription)
        } catch {
            completion(error.localizedDescription)
        }
    }
    
    // MARK: - Validation
    
    func validateFields(with user: FirebaseUser) throws {
        if isEmpty(user.name) ||
            isEmpty(user.phone) ||
            isEmpty(user.email) ||
            isEmpty(user.dateOfBirth) ||
            isEmpty(user.password) {
            throw RegisterError.emptyFields
        }
        
        if !isPasswordValid(user.password!) {
            throw RegisterError.invalidPassword
        }
    }
    
    private func isEmpty(_ text: String?) -> Bool {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
    private func isPasswordValid(_ password: String) -> Bool {
        let cleanedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
        return passwordTest.evaluate(with: cleanedPassword)
    }
    
    // MARK: - Helper Methods
    
    func stringFrom(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: date)
    }
    
}
