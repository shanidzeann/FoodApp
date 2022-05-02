//
//  DeliveryViewController+MKMapViewDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.04.2022.
//

import UIKit
import MapKit

extension DeliveryViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        reverseGeocodeLocation()
    }
    
    private func reverseGeocodeLocation() {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemark, error) in
            guard let self = self else { return }
            if let error = error {
                // alert
                print(error)
                return
            }
            
            guard let placemark = placemark?.first else {
                // alert
                return
            }
            
            self.setNewAdress(from: placemark)
        }
    }
    
    private func setNewAdress(from placemark: CLPlacemark) {
        let streetNumber = placemark.subThoroughfare ?? ""
        let streetName = placemark.thoroughfare ?? ""
        
        self.addressLabel.text = streetNumber + " " + streetName
    }
    
}
