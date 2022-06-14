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
    
    private let dbManager: FirestoreManagerProtocol
    
    init(databaseManager: FirestoreManagerProtocol) {
        self.dbManager = databaseManager
    }
    
    func create(_ user: FirebaseUser, completion: @escaping (String?) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password!) { [weak self] (result, error) in
            if error != nil {
                completion(error?.localizedDescription)
            }
            else {
                let data = self?.data(of: user, with: result!.user.uid) ?? [:]
                self?.dbManager.createDocument(in: "users", documentPath: result!.user.uid, data: data) { error in
                    completion(error?.localizedDescription)
                }
            }
        }
    }
    
    private func data(of user: FirebaseUser, with id: String) -> [String: Any] {
        return [
            "name": user.name!,
            "phone": user.phone!,
            "dateOfBirth": user.dateOfBirth!,
            "uid": id
        ]
    }
    
    
    func authorize(_ user: FirebaseUser, completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: user.email, password: user.password!) { (result, error) in
            completion(error?.localizedDescription)
        }
    }
    
}
