//
//  ReservationListModel.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/19/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class ReservationListModel: ServerAccessModel, BaseModel {
    
    var currentReservations: [ReservationDetailModel]? = nil
    var pastReservations: [PastReservationModel]? = nil
    
    var ownerCurrentReservations: [ReservationDetailModel]? = nil
    var ownerPastReservations: [PastReservationModel]? = nil
    
    enum LoadUserReservationListResult {
        case success
        case failure
    }
    
    func loadData(callback: @escaping (LoadUserReservationListResult) -> Void) {
        sendGetRequest(toURL: Configurations.API_ROOT + Configurations.API_URL.getUserRecordList.rawValue) {
            (statusCode, responseData) in
            if statusCode == 200 {
                let jsonData = JSON(responseData!)
                let listData = jsonData["data"].arrayValue
                self.currentReservations = [ReservationDetailModel]()
                self.pastReservations = [PastReservationModel]()
                for reservationEntry in listData {
                    self.parseReservationData(jsonData: reservationEntry)
                }
                callback(.success)
            } else {
                callback(.failure)
            }
        }
    }
    
    func parseReservationData(jsonData: JSON) {
        print(jsonData)
        let pid = jsonData["pid"].stringValue
        print("PID " + pid)
        let startDate = convertMySQLDateStringToDateString(mySQLDateString: jsonData["start_date"].stringValue)
        let startTime = jsonData["start_time"].doubleValue
        let endTime = jsonData["end_time"].doubleValue
        let totalCharges = jsonData["total_charges"].doubleValue
        let plate = jsonData["plate"].stringValue
        let title = jsonData["title"].stringValue
        let address = jsonData["address"].stringValue
        let latitude = jsonData["latitude"].doubleValue
        let longitude = jsonData["longitude"].doubleValue
        let description = jsonData["description"].stringValue
        print("Description " + description)
        
        if isTimeInPast(date: startDate, time: endTime) {
            let reservationModel = PastReservationModel()
            reservationModel.requestedDate = startDate
            reservationModel.requestedStartHourValue = startTime
            reservationModel.requestedEndHourValue = endTime
            reservationModel.totalRate = totalCharges
            reservationModel.plate = plate
            reservationModel.title = title
            reservationModel.address = address
            reservationModel.latitude = latitude
            reservationModel.longitude = longitude
            reservationModel.description = description
            pastReservations?.append(reservationModel)
            print(description)
        } else {
            let reservationModel = ReservationDetailModel()
            reservationModel.requestedDate = startDate
            reservationModel.requestedStartHourValue = startTime
            reservationModel.requestedEndHourValue = endTime
            reservationModel.totalRate = totalCharges
            reservationModel.plate = plate
            reservationModel.title = title
            reservationModel.address = address
            reservationModel.latitude = latitude
            reservationModel.longitude = longitude
            reservationModel.description = description
            reservationModel.postModel = PostModel()
            reservationModel.postModel?.pid = pid
            currentReservations?.append(reservationModel)
        }
    }
    
    func isTimeInPast(date: String, time: Double) -> Bool {
        let timeString = timeDoubleRepresentationToStringRepresentation(time: time)
        let timeDateString = date + " " + timeString!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let currentTimeString = dateFormatter.string(from: Date())
        let currentTime = dateFormatter.date(from: currentTimeString)!
        let time = dateFormatter.date(from: timeDateString)!
        print(timeDateString)
        print(time)
        print(currentTime)
        return time < currentTime
    }

}
