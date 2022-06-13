//
//  FirestoreManagerProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 12.06.2022.
//

import Foundation
import FirebaseAuth

protocol FirestoreManagerProtocol {
    func createDocument(in collection: String, documentPath: String?, data: [String: Any], completion: @escaping (Error?) -> Void)
    func getUserData(completion: @escaping (Result<FirebaseUser, Error>) -> Void)
    func currentUser() -> User?
    func createOrder(with menuItems: [CartItem], totalPrice: Int)
    func getUserOrders(completion: @escaping (Result<[Order], Error>) -> Void)
}
