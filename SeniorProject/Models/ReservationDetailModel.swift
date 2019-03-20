//
//  ReservationDetailModel.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/19/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class ReservationDetailModel: ServerAccessModel, BaseModel {
    
    var postModel: PostModel? = nil
    var totalRate: Double? = nil
    var requestedDateValue: String? = nil
    var requestedStartHourValue: Double? = nil
    var requestedEndHourValue: Double? = nil
    
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
    
    enum PostReservationResult {
        case success
        case availabilityAltered
        case serverError
    }
    
    func post(onCompletion callback: @escaping (PostReservationResult) -> Void) {
        let formattedStartDate = convertDateStringToMySQLDateString(dateString: requestedDate!)
        let data = JSON([
            "pid": postModel!.pid!,
            "start_date": formattedStartDate,
            "start_time": requestedStartHourValue!,
            "end_time": requestedEndHourValue!,
            "plate": "CA 7YVD694",
            "total_charges": totalRate!
        ])
        let apiURLString = Configurations.API_ROOT + Configurations.API_URL.newRecord.rawValue
        sendPostRequest(toURL: apiURLString, withData: data.rawString(String.Encoding.utf8, options: [])!) {
            (statusCode, responseData) in
            if (statusCode != 200) {
                if (statusCode == 409) {
                    callback(.availabilityAltered)
                } else {
                    callback(.serverError)
                }
            } else {
                callback(.success)
            }
        }
    }

}
