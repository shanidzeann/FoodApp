//
//  DeliveryPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 22.04.2022.
//

import Foundation

class DeliveryPresenter: DeliveryPresenterProtocol {
    
    weak var view: DeliveryViewProtocol?
    var mapsManager: MapsManagerProtocol!
    
    // MARK: - Init
    
    required init(view: DeliveryViewProtocol, mapsManager: MapsManagerProtocol) {
        self.view = view
        self.mapsManager = mapsManager
    }
    
    func loadInitialData() {
        guard let data = mapsManager.loadInitialData() else { return }
        view?.addAnnotations(restaurants: data)
    }
}
