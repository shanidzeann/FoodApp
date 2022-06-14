//
//  CheckoutPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 13.06.2022.
//

import Foundation
import CoreLocation

class CheckoutPresenter: CheckoutPresenterProtocol {
    
    weak var view: CheckoutViewProtocol?
    private var firestoreManager: FirestoreManagerProtocol!
    private var localDatabaseManager: LocalDatabaseManagerProtocol!
    
    lazy var deliveryRegionCenter = CLLocationCoordinate2D(latitude: 55.751999, longitude: 37.617734)
    lazy var deliveryRegion = CLCircularRegion(center: deliveryRegionCenter, radius: 20000, identifier: "delivery")
    
    init(
        view: CheckoutViewProtocol,
        firestoreManager: FirestoreManagerProtocol,
        localDatabaseManager: LocalDatabaseManagerProtocol
    ) {
        self.view = view
        self.firestoreManager = firestoreManager
        self.localDatabaseManager = localDatabaseManager
    }
    
    func getData() {
        firestoreManager.getUserData { result in
            switch result {
            case .success(let user):
                self.view?.setData(phone: user.phone ?? "",
                                   username: user.name ?? "",
                                   totalPrice: "\(self.localDatabaseManager.totalPrice) ₽")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func checkout(_ order: Order) {
        if areFieldsValid(order: order) {
            var orderCopy = order
            check(order.address) { passed, message in
                if passed {
                    orderCopy.menuItems = self.localDatabaseManager.items
                    orderCopy.totalPrice = self.localDatabaseManager.totalPrice
                    self.firestoreManager.createOrder(orderCopy) { message in
                        self.view?.closeOrder(with: message)
                    }
                } else {
                    self.view?.show(message)
                }
            }
        } else {
            view?.show("Заполните все поля")
        }
    }
    
    func check(_ address: String, completion: @escaping (Bool, String) -> Void) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks,
                  let location = placemarks.first?.location
            else {
                print(error?.localizedDescription as Any)
                completion(false, "Некорректный адрес")
                return
            }
            if self.deliveryRegion.contains(location.coordinate) {
                completion(true, "Доставка доступна")
            } else {
                completion(false, "Доставка недоступна")
            }
            
        }
    }
    
    func areFieldsValid(order: Order) -> Bool {
        return !isEmpty(order.userName) &&
        !isEmpty(order.userPhone) &&
        !isEmpty(order.address) &&
        !isEmpty(order.apartment) &&
        !isEmpty(order.floor)
    }
    
    private func isEmpty(_ text: String?) -> Bool {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
    func emptyShoppingCart() {
        localDatabaseManager.deleteAll()
    }
    
}
