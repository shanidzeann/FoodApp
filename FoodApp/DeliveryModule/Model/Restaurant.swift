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
}
