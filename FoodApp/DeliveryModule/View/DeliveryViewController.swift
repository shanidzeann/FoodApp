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
    
    let mapView: MKMapView = {
        let map = MKMapView()
        //  map.overrideUserInterfaceStyle = .dark
        return map
    }()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapConstraints()
//        setInitialLocation()
//        constrainCamera()
        addAnnotation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
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
    
    private func setInitialLocation() {
        let initialLocation = CLLocation(latitude: 55.752004, longitude: 37.617734)
        mapView.centerLocation(initialLocation)
    }
    
    private func constrainCamera() {
        let center = CLLocation(latitude: 55.752004, longitude: 37.617734)
        let region = MKCoordinateRegion(center: center.coordinate, latitudinalMeters: 50000, longitudinalMeters:  50000)
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 100000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
    }
    
    private func addAnnotation() {
        let restaurant = Restaurant(
          title: "The Best Restaurant Ever",
          locationName: "The Best Location Ever",
          discipline: "Restaurant",
          coordinate: CLLocationCoordinate2D(latitude: 55.752004, longitude: 37.617734))
        mapView.addAnnotation(restaurant)
    }
    
    deinit {
        print("deinit")
    }
}

extension DeliveryViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.startUpdatingLocation()
            
            render(location)
        }
    }
    
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}


extension MKMapView {
    func centerLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
