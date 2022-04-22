//
//  DeliveryViewController+CLLocationManagerDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 22.04.2022.
//

import UIKit
import CoreLocation

extension DeliveryViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.startUpdatingLocation()
            render(location)
        }
    }
}
