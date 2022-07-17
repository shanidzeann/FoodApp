//
//  FirestoreManager.swift
//  FoodApp
//
//  Created by Anna Shanidze on 12.06.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class FirestoreManager: FirestoreManagerProtocol {
    
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
            completion(error)
        }
    }
    
    // MARK: - User Data
    
    #warning("auth manager")
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
    
    func createOrder(_ order: Order, completion: @escaping (String) -> Void) {
        let orderData = data(of: order)
        let docRef = db.collection("orders").document()
        docRef.setData(orderData)
        
        for item in order.orderItems! {
            let data = data(of: item)
            docRef.collection("orderItems").addDocument(data: data) { error in
                let message = error != nil ? error!.localizedDescription : "Заказ оформлен успешно"
                completion(message)
            }
        }
    }
    
    private func data(of order: Order) -> [String: Any] {
        return [
            "userID": currentUser()?.uid as Any,
            "address": order.address,
            "apartment": order.apartment,
            "floor": order.floor,
            "date": Date(),
            "totalPrice": order.totalPrice as Any,
            "userName": order.userName,
            "userPhone": order.userPhone
        ]
    }
    
    private func data(of item: OrderItem) -> [String: Any] {
        return [
            "id": item.id,
            "title": item.title,
            "description": item.description,
            "price": item.price,
            "imageUrl": item.imageUrl,
            "count": item.count
        ]
    }
    
    func getUserOrders(completion: @escaping (Result<[Order], Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser else { return }
        var orders = [Order]()
        
        db.collection("orders").whereField("userID", isEqualTo: currentUser.uid).getDocuments { querySnapshot, error in
            guard error == nil else {
                print("Error getting documents: \(error!)")
                completion(.failure(error!))
                return
            }
            
            let dispatchGroup = DispatchGroup()
            for document in querySnapshot!.documents {
                dispatchGroup.enter()
                let data = document.data()
                self.getOrderItems(documentID: document.documentID) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let items):
                        let order = self.order(from: data, with: items)
                        orders.append(order)
                    case .failure(let error):
                        print(error)
                    }
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(.success(orders))
            }
        }
    }
    
    private func order(from data: [String: Any], with items: [OrderItem]) -> Order {
        return Order(orderItems: items,
                     userID: data["userID"] as? String,
                     address: data["address"] as! String,
                     apartment: data["apartment"] as! String,
                     floor: data["floor"] as! String,
                     date: (data["date"] as! Timestamp).dateValue(),
                     totalPrice: data["totalPrice"] as? Int,
                     userName: data["userName"] as! String,
                     userPhone: data["userPhone"] as! String)
    }
    
    func getOrderItems(documentID: String, completion: @escaping (Result<[OrderItem], Error>) -> Void) {
        var orderItems = [OrderItem]()
        db.collection("orders").document(documentID).collection("orderItems").getDocuments { [weak self] querySnapshot, error in
            guard error == nil else {
                print("Error getting documents: \(error!)")
                completion(.failure(error!))
                return
            }
            
            for document in querySnapshot!.documents {
                let data = document.data()
                guard let item = self?.orderItem(from: data) else { return }
                orderItems.append(item)
            }
            
            completion(.success(orderItems))
        }
    }
    
    private func orderItem(from data: [String: Any]) -> OrderItem? {
        guard let id = data["id"] as? Int,
              let title = data["title"] as? String,
              let description = data["description"] as? String,
              let price = data["price"] as? Int,
              let imageUrl = data["imageUrl"] as? String,
              let count = data["count"] as? Int else { return nil }
        return OrderItem(id: id,
                        title: title,
                        description: description,
                        price: price,
                        imageUrl: imageUrl,
                        count: count)
    }
    
}
