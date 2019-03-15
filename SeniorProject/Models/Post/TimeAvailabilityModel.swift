//
//  TimeAvailabilityModel.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/2/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class TimeAvailabilityModel: NSObject {
    
    var start: Double
    var end: Double
    var rate: Double
    
    var discreteListRepresentation: [Double] {
        get {
            var availabilityItemList = [Double]()
            for i in stride(from: start, to: end, by: 0.5) {
                availabilityItemList.append(i)
            }
            return availabilityItemList
        }
    }
    
    init(start: Double, end: Double, rate: Double) {
        self.start = start
        self.end = end
        self.rate = rate
    }

}
