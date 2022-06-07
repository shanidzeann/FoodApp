//
//  AuthManager.swift
//  FoodApp
//
//  Created by Anna Shanidze on 04.05.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class AuthManager: AuthManagerProtocol {
    
    func createUser(_ user: FirebaseUser, completion: (String?) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { (result, error) in
            if error != nil {
                completion("Error creating user")
            }
            else {
                let db = Firestore.firestore()
                
                db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
                    
                    if error != nil {
             //           self.showError("Error saving user data")
                    }
                }
                
                
             //   self.transitionToHome()
            }
            
        }
    }
    
    
    
    
}
