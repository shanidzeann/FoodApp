//
//  FirestoreManager.swift
//  FoodApp
//
//  Created by Anna Shanidze on 12.06.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirestoreManager: FirestoreManagerProtocol {
    
    private let db = Firestore.firestore()
    
    func createDocument(in collection: String,
                        documentPath: String?,
                        data: [String: Any],
                        completion: @escaping (Error?) -> Void) {
        let docRef: DocumentReference
        if documentPath == nil {
            docRef = db.collection(collection).document()
        } else {
            docRef = db.collection(collection).document(documentPath!)
        }
        docRef.setData(data) { (error) in
            if error != nil {
                completion(error!)
            }
        }
    }
    
    // MARK: - User Data
    
    func currentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    func getUserData(completion: @escaping (Result<FirebaseUser, Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser else { return }
        let docRef = db.collection("users").document(currentUser.uid)
        
        getDocument(docRef) { result in
            switch result {
            case .success(let dataDescription):
                let user = FirebaseUser(name: dataDescription["name"] as? String,
                                        email: currentUser.email ?? "",
                                        phone: dataDescription["phone"] as? String)
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func getDocument(_ docRef: DocumentReference, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        docRef.getDocument { (document, error) in
            if let document = document,
               document.exists,
               let dataDescription = document.data() {
                completion(.success(dataDescription))
            } else {
                print("Document does not exist")
                completion(.failure(error!))
            }
        }
    }
    
    // MARK: - Orders
    
    func createOrder(with menuItems: [CartItem]) {
        let data: [String: Any] = [
            "userID": currentUser()?.uid as Any,
            "address": ""
        ]
        let docRef = db.collection("orders").document()
        docRef.setData(data)
        
        for item in menuItems {
            let data: [String: Any] = [
                "id": item.id,
                "title": item.title,
                "description": item.description,
                "price": item.price,
                "imageUrl": item.imageUrl,
                "count": item.count
            ]
            docRef.collection("menuItems").addDocument(data: data)
        }
    }
    
    func getUserOrders(completion: @escaping (Result<[Order], Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser else { return }
        var orders = [Order]()
        
        db.collection("orders").whereField("userID", isEqualTo: currentUser.uid).getDocuments { querySnapshot, error in
            let dispatchGroup = DispatchGroup()
            if let error = error {
                print("Error getting documents: \(error)")
                completion(.failure(error))
            } else {
                for document in querySnapshot!.documents {
                    dispatchGroup.enter()
                    let data = document.data()
                    self.getMenuItems(documentID: document.documentID) { result in
                        switch result {
                        case .success(let items):
                            let order = Order(menuItems: items,
                                              userID: data["userID"] as! String,
                                              address: data["address"] as! String)
                            orders.append(order)
                            dispatchGroup.leave()
                        case .failure(let error):
                            print(error)
                            dispatchGroup.leave()
                        }
                    }
                }
                dispatchGroup.notify(queue: .main) {
                    completion(.success(orders))
                }
            }
        }
    }
    
    func getMenuItems(documentID: String, completion: @escaping (Result<[CartItem], Error>) -> Void) {
        var menuItems = [CartItem]()
        db.collection("orders").document(documentID).collection("menuItems").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(.failure(error))
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    guard let id = data["id"] as? Int,
                          let title = data["title"] as? String,
                          let description = data["description"] as? String,
                          let price = data["price"] as? Int,
                          let imageUrl = data["imageUrl"] as? String,
                          let count = data["count"] as? Int else { return }
                    let menuItem = CartItem(id: id,
                                            title: title,
                                            description: description,
                                            price: price,
                                            imageUrl: imageUrl,
                                            count: count)
                    menuItems.append(menuItem)
                }
                completion(.success(menuItems))
            }
        }
    }
    
}
