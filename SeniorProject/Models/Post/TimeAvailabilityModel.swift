//
//  TimeAvailabilityModel.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/2/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class TimeAvailabilityModel: NSObject {
    
    var start: Int
    var end: Int
    var rate: Double
    
    init(start: Int, end: Int, rate: Double) {
        self.start = start
        self.end = end
        self.rate = rate
    }
    
    func getTimeAvailbilityTableItemList() -> [Double] {
        return [1]
    }

}
