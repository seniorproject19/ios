//
//  ReservationModel.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/19/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class ReservationModel: BaseModel {
    
    var totalRate: Double? = nil
    var requestedDateValue: String? = nil
    var requestedStartHourValue: Double? = nil
    var requestedEndHourValue: Double? = nil
    var plate: String?
    var title: String?
    var description: String?
    var address: String?
    var latitude: Double?
    var longitude: Double?
    var pid: String?
    
    var requestedDate: String?  {
        get {
            return requestedDateValue
        }
        set(dateString) {
            if dateString == "Today" {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                requestedDateValue = dateFormatter.string(from: Date())
            } else {
                requestedDateValue = dateString
            }
        }
    }
    
    var requestedStartHour: String? {
        get {
            return timeDoubleRepresentationToStringRepresentation(time: requestedStartHourValue)
        }
        set(time) {
            self.requestedStartHourValue = timeStringRepresentationToDoubleRepresentation(time: time)
        }
    }
    
    var requestedEndHour: String? {
        get {
            return timeDoubleRepresentationToStringRepresentation(time: requestedEndHourValue)
        }
        set(time) {
            self.requestedEndHourValue = timeStringRepresentationToDoubleRepresentation(time: time)
        }
    }
    
    var requestedTimeDescription: String {
        get {
            if requestedDate == nil || requestedStartHour == nil || requestedEndHour == nil {
                return ""
            }
            return requestedDate! + " " + requestedStartHour! + " - " + requestedEndHour!
        }
    }

}
