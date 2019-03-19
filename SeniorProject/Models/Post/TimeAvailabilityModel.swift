//
//  TimeAvailabilityModel.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/2/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class TimeAvailabilityModel: NSObject {
    
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
    
    override var description: String {
        if weekday == nil || startString == nil || endString == nil || rate == nil {
            return ""
        }
        return weekday! + " " + startString! + " - " + endString! + ", $" + String(rate!) + "/hr"
    }
    
    override init() {
        super.init()
        self.weekday = nil
        self.start = nil
        self.end = nil
        self.rate = nil
        self.startString = nil
        self.endString = nil
    }
    
    init(weekday: String, start: Double, end: Double, rate: Double) {
        super.init()
        self.weekday = weekday
        self.start = start
        self.end = end
        self.rate = rate
    }
    
    init(jsonData: JSON) {
        super.init()
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
    
    func timeStringRepresentationToDoubleRepresentation(time: String?) -> Double? {
        if time == nil {
            return nil
        }
        let amPmSeperatedArray = time!.components(separatedBy: " ")
        let hoursMinutesSeperatedArray = amPmSeperatedArray[0].components(separatedBy: ":")
        var result: Double?
        if amPmSeperatedArray[1] == "AM" {
            if hoursMinutesSeperatedArray[0] == "12" {
                result = 0
            } else {
                result = Double(hoursMinutesSeperatedArray[0])
            }
        } else {
            if hoursMinutesSeperatedArray[0] == "12" {
                result = 12
            } else {
                let hour = Double(hoursMinutesSeperatedArray[0])
                if hour != nil {
                    result = 12 + hour!
                }
            }
        }
        if hoursMinutesSeperatedArray[1] == "30" {
            if result != nil {
                result = result! + 0.5
            }
        }
        return result
    }
    
    func timeDoubleRepresentationToStringRepresentation(time: Double?) -> String? {
        if (time == nil) {
            return nil
        }
        var minute = "00"
        var amPm = "AM"
        let rawHour = Int(time!)
        var hour = String(rawHour)
        if rawHour == 0 {
            hour = "12"
        }
        if rawHour == 12 {
            hour = "12"
            amPm = "PM"
        }
        if rawHour > 12 {
            hour = String(rawHour - 12)
            amPm = "PM"
        }
        if time! - Double(rawHour) == 0.5 {
            minute = "30"
        }
        return hour + ":" + minute + " " + amPm
    }

}
