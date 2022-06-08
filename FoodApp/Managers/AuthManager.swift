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
    
    func createUser(_ user: FirebaseUser, completion: @escaping (String?) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { (result, error) in
            if error != nil {
                completion(error?.localizedDescription)
            }
            else {
                let db = Firestore.firestore()
                
                let data: [String: Any] = [
                    "name": user.name,
                    "phone": user.phone,
                    "dateOfBirth": user.dateOfBirth,
                    "uid": result!.user.uid
                ]
                
                db.collection("users").addDocument(data: data) { (error) in
                    if error != nil {
                        completion(error?.localizedDescription)
                    }
                }
                
                //self.transitionToHome()
                completion(nil)
            }
            
        }
    }
}
