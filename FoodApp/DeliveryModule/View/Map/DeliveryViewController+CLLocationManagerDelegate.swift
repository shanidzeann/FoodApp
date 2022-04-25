//
//  DeliveryViewController+CLLocationManagerDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 22.04.2022.
//

import UIKit
import CoreLocation
import MapKit

extension DeliveryViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
