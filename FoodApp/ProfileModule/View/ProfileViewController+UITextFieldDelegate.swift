//
//  ProfileViewController+UITextFieldDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 03.05.2022.
//

import UIKit

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return false
    }
}
