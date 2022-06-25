//
//  Restaurant.swift
//  FoodApp
//
//  Created by Anna Shanidze on 22.04.2022.
//

import Foundation
import MapKit

class Restaurant: NSObject, MKAnnotation {
    let title: String?
    let locationName: String?
    let discipline: String?
    let coordinate: CLLocationCoordinate2D
    
    var subtitle: String? {
        return locationName
    }
    
    init(
        title: String?,
        locationName: String?,
        discipline: String?,
        coordinate: CLLocationCoordinate2D
    ) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    init?(feature: MKGeoJSONFeature) {
        guard
            let point = feature.geometry.first as? MKPointAnnotation,
            let propertiesData = feature.properties,
            let json = try? JSONSerialization.jsonObject(with: propertiesData),
            let properties = json as? [String: Any] else { return nil }
        title = properties["title"] as? String
        locationName = properties["location"] as? String
        discipline = properties["discipline"] as? String
        coordinate = point.coordinate
        super.init()
    }
}

