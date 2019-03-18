//
//  POIAnnotation.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/17/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit
import MapKit
class POIAnnotation: NSObject, MKAnnotation {
    let pointOfInterest: PostListEntryModel
    var coordinate: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: pointOfInterest.latitude, longitude: pointOfInterest.longitude)  }
    
    init(point: PostListEntryModel) {
        self.pointOfInterest = point
        super.init()
    }
    
    var title: String? { return pointOfInterest.title }
    var subtitle: String? {
        return "(\(pointOfInterest.latitude), \(pointOfInterest.longitude))"
    }
}
