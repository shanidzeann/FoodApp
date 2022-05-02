//
//  DeliveryViewController+DeliveryViewProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 02.05.2022.
//

import UIKit

extension DeliveryViewController: DeliveryViewProtocol {
    func addAnnotations(restaurants: [Restaurant]) {
        mapView.addAnnotations(restaurants)
    }
}
