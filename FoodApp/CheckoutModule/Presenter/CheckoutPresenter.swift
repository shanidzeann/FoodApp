//
//  CheckoutPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 13.06.2022.
//

import Foundation
import CoreLocation

class CheckoutPresenter: CheckoutPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: CheckoutViewProtocol?
    private var firestoreManager: FirestoreManagerProtocol!
    private var localDatabaseManager: LocalDatabaseManagerProtocol!
    
    #warning("manager?")
    lazy var deliveryRegionCenter = CLLocationCoordinate2D(latitude: 55.751999, longitude: 37.617734)
    lazy var deliveryRegion = CLCircularRegion(center: deliveryRegionCenter, radius: 20000, identifier: "delivery")
    
    // MARK: - Init
    
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
        firestoreManager.getUserData { [weak self] result in
            switch result {
            case .success(let user):
                self?.view?.setData(phone: user.phone ?? "",
                                   username: user.name ?? "",
                                    totalPrice: "\(self?.localDatabaseManager.totalPrice ?? 0) ₽")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func checkout(_ order: Order) {
        if areFieldsValid(order: order) {
            check(order.address) { [weak self] passed, message in
                if passed {
                    self?.confirm(order)
                } else {
                    self?.view?.show(message)
                }
            }
        } else {
            view?.show("Заполните все поля")
        }
    }
    
    private func areFieldsValid(order: Order) -> Bool {
        return !isEmpty(order.userName) &&
        !isEmpty(order.userPhone) &&
        !isEmpty(order.address) &&
        !isEmpty(order.apartment) &&
        !isEmpty(order.floor)
    }
    
    private func isEmpty(_ text: String?) -> Bool {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
    private func confirm(_ order: Order) {
        var orderCopy = order
        orderCopy.orderItems = localDatabaseManager.items
        orderCopy.totalPrice = localDatabaseManager.totalPrice
        firestoreManager.createOrder(orderCopy) { [weak self] message in
            self?.view?.closeOrder(with: message)
        }
    }
    
    func check(_ address: String, completion: @escaping (Bool, String) -> Void) {
        CLGeocoder().geocodeAddressString(address) { [weak self] (placemarks, error) in
            guard let placemarks = placemarks,
                  let location = placemarks.first?.location,
                  let self = self
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
    
    func emptyShoppingCart() {
        localDatabaseManager.deleteAll()
    }
    
}
