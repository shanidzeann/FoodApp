//
//  MapsManager.swift
//  FoodApp
//
//  Created by Anna Shanidze on 22.04.2022.
//

import Foundation
import MapKit

class MapsManager: MapsManagerProtocol {
    func loadInitialData() -> [Restaurant]? {
        guard let fileName = Bundle.main.url(forResource: "restaurants", withExtension: "geojson"),
              let restaurantsData = try? Data(contentsOf: fileName) else { return nil }
        do {
            let features = try MKGeoJSONDecoder().decode(restaurantsData).compactMap { $0 as? MKGeoJSONFeature }
            let valid = features.compactMap(Restaurant.init)
            return valid
        } catch {
            print("Unexpected error: \(error).")
        }
        return nil
    }
}
