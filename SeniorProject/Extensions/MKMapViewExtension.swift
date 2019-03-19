//
//  MKMapViewExtension.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/18/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit
import MapKit

extension MKMapView {
    
    func topLeftCoordinate() -> CLLocationCoordinate2D {
        return convert(.zero, toCoordinateFrom: self)
    }
    
    func bottomRightCoordinate() -> CLLocationCoordinate2D {
        return convert(CGPoint(x: frame.width, y: frame.height), toCoordinateFrom: self)
    }
    
}
