//
//  DeliveryViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 22.04.2022.
//

import UIKit
import MapKit

class DeliveryViewController: UIViewController {
    
    let mapView: MKMapView = {
        let map = MKMapView()
        //  map.overrideUserInterfaceStyle = .dark
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapConstraints()
        let initialLocation = CLLocation(latitude: 59.929691, longitude: 30.362239)
        mapView.centerLocation(initialLocation)
    }
    
    private func setupMapConstraints() {
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        mapView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
    }
    
    deinit {
        print("deinit")
    }
}




extension MKMapView {
    func centerLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
