//
//  TimeAvailabilityTableModel.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/13/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class TimeAvailabilityTableModel: NSObject {
    
    var timeAvailabilityEntries = [TimeAvailabilityModel]()
    
    var timeAvailabilityTable = [
        "Monday": [Double: Double](),
        "Tuesday": [Double: Double](),
        "Wednesday": [Double: Double](),
        "Thursday": [Double: Double](),
        "Friday": [Double: Double]()
    ]
    
    func addAvailability(weekday: String, availability: TimeAvailabilityModel) {
        // timeAvailabilityTable[weekday]?.append(availability)
        let availabilityItemList = availability.discreteListRepresentation
        timeAvailabilityEntries.append(availability)
        for availabilityItem in availabilityItemList {
            timeAvailabilityTable[weekday]![availabilityItem] = availability.rate
        }
    }

}
