//
//  MapAnnotation.swift
//  Navigation
//
//  Created by Ольга Бойко on 10.08.2023.
//

import Foundation
import MapKit

final class MapAnnotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate : CLLocationCoordinate2D) {
        super.init()
        self.coordinate = coordinate
    }
}
