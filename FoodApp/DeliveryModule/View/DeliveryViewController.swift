//
//  DeliveryViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 22.04.2022.
//

import UIKit
import MapKit
import CoreLocation

class DeliveryViewController: UIViewController {
    
    private var presenter: DeliveryPresenterProtocol!
    
    let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapConstraints()
        
        checkLocationServices()
        
        presenter.loadInitialData()
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
    
    func inject(presenter: DeliveryPresenterProtocol) {
        self.presenter = presenter
    }
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // show alert
        }
    }
    
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // alert
            break
        case .denied:
            // alert
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    private func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    private func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }

}

extension DeliveryViewController: DeliveryViewProtocol {
    func addAnnotations(restaurants: [Restaurant]) {
        mapView.addAnnotations(restaurants)
    }
}
