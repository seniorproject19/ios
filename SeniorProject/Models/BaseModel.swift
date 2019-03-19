//
//  BaseModel.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/18/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

protocol BaseModel {
    
    func timeStringRepresentationToDoubleRepresentation(time: String?) -> Double?
    func timeDoubleRepresentationToStringRepresentation(time: Double?) -> String?
    
}

extension BaseModel {
    
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
