//
//  TimeAvailabilityModel.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/2/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class TimeAvailabilityModel: BaseModel {
    
    var weekday: String?
    var rate: Double?
    var startString: String?
    var endString: String?
    
    var start: Double? {
        get {
            return timeStringRepresentationToDoubleRepresentation(time: startString)
        }
        set(time) {
            self.startString = timeDoubleRepresentationToStringRepresentation(time: time)
        }
    }
    
    var end: Double? {
        get {
            return timeStringRepresentationToDoubleRepresentation(time: endString)
        }
        set(time) {
            self.endString = timeDoubleRepresentationToStringRepresentation(time: time)
        }
    }
    
    var discreteListRepresentation: [Double] {
        get {
            var availabilityItemList = [Double]()
            for i in stride(from: start!, to: end!, by: 0.5) {
                availabilityItemList.append(i)
            }
            return availabilityItemList
        }
    }
    
    var description: String {
        if weekday == nil || startString == nil || endString == nil || rate == nil {
            return ""
        }
        return weekday! + " " + startString! + " - " + endString! + ", $" + String(rate!) + "/hr"
    }
    
    init() {
        self.weekday = nil
        self.start = nil
        self.end = nil
        self.rate = nil
        self.startString = nil
        self.endString = nil
    }
    
    init(weekday: String, start: Double, end: Double, rate: Double) {
        self.weekday = weekday
        self.start = start
        self.end = end
        self.rate = rate
    }
    
    init(jsonData: JSON) {
        let weekdayFormatConversionTable = [
            "Mon": "Monday",
            "Tue": "Tuesday",
            "Wed": "Wednesday",
            "Thu": "Thursday",
            "Fri": "Friday",
            "Sat": "Saturday",
            "Sun": "Sunday"
        ]
        self.weekday = weekdayFormatConversionTable[jsonData["weekday"].stringValue]
        self.start = jsonData["start_time"].doubleValue
        self.end = jsonData["end_time"].doubleValue
        self.rate = jsonData["hourly_rate"].doubleValue
    }

}
