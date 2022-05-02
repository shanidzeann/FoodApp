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
    var previousLocation: CLLocation?
    lazy var deliveryAlert = DeliveryAlert()
    
    lazy var deliveryRegionCenter = CLLocationCoordinate2D(latitude: 55.751999, longitude: 37.617734)
    lazy var deliveryRegion = CLCircularRegion(center: deliveryRegionCenter, radius: 20000, identifier: "delivery")
    
    let pinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "pin")
        return imageView
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.backgroundColor = .secondarySystemBackground
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let userLocationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.backgroundColor = .systemRed
        button.tintColor = .white
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let checkAddressButton: UIButton = {
        let button = UIButton()
        button.setTitle("Проверить", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        addSubviews()
        setupConstraints()
        checkLocationServices()
        presenter.loadInitialData()
        addTargets()
    }
    
    func inject(presenter: DeliveryPresenterProtocol) {
        self.presenter = presenter
    }
    
    private func addTargets() {
        userLocationButton.addTarget(self, action: #selector(showUserLocation), for: .touchUpInside)
        checkAddressButton.addTarget(self, action: #selector(didTapCheckAddress), for: .touchUpInside)
    }
    
    @objc private func showUserLocation() {
        centerViewOnUserLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    @objc private func didTapCheckAddress() {
        if deliveryIsAvailable() {
            showDeliveryTerms()
        } else {
            showDeliveryIsUnavailableAlert()
        }
    }
    
    private func deliveryIsAvailable() -> Bool {
        let location = getCenterLocation(for: mapView)
        return deliveryRegion.contains(location.coordinate)
    }
    
    private func showDeliveryTerms() {
        let deliveryTermsVC = DeliveryTermsViewController()
        deliveryTermsVC.modalPresentationStyle = .custom
        deliveryTermsVC.transitioningDelegate = self
        present(deliveryTermsVC, animated: true, completion: nil)
    }
    
    private func showDeliveryIsUnavailableAlert() {
        deliveryAlert.showAlert(on: self)
    }
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // show alert
        }
    }
    
    private func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
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
            startTrackingUserLocation()
        @unknown default:
            break
        }
    }
    
    private func startTrackingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    private func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    private func addSubviews() {
        view.addSubview(mapView)
        view.addSubview(pinImageView)
        view.addSubview(addressLabel)
        view.addSubview(userLocationButton)
        view.addSubview(checkAddressButton)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
        pinImageView.translatesAutoresizingMaskIntoConstraints = false
        pinImageView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -20.0).isActive = true
        pinImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        pinImageView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        pinImageView.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 60).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -60).isActive = true
        addressLabel.bottomAnchor.constraint(equalTo: checkAddressButton.topAnchor, constant: -10).isActive = true
        addressLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        userLocationButton.translatesAutoresizingMaskIntoConstraints = false
        userLocationButton.leadingAnchor.constraint(equalTo: addressLabel.trailingAnchor, constant: 10).isActive = true
        userLocationButton.centerYAnchor.constraint(equalTo: addressLabel.centerYAnchor).isActive = true
        userLocationButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        userLocationButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        checkAddressButton.translatesAutoresizingMaskIntoConstraints = false
        checkAddressButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20).isActive = true
        checkAddressButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20).isActive = true
        checkAddressButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -30).isActive = true
        checkAddressButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
}
