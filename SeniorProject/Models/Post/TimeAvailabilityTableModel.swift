//
//  TimeAvailabilityTableModel.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/13/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class TimeAvailabilityTableModel: ServerAccessModel {
    
    var timeAvailabilityEntries = [TimeAvailabilityModel]()
    
    var timeAvailabilityTable = [
        "Monday": [Double: Double](),
        "Tuesday": [Double: Double](),
        "Wednesday": [Double: Double](),
        "Thursday": [Double: Double](),
        "Friday": [Double: Double](),
        "Saturday": [Double: Double](),
        "Sunday": [Double: Double]()
    ]
    
    var description: String {
        get {
            var result = ""
            for availabilityModel in timeAvailabilityEntries {
                result += availabilityModel.description + "\n"
            }
            return result.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    enum AvailabilityPostResult {
        case success
        case timeConflict
    }
    
    func addAvailability(availability: TimeAvailabilityModel) -> AvailabilityPostResult {
        let availabilityItemList = availability.discreteListRepresentation
        for availabilityItem in availabilityItemList {
            if timeAvailabilityTable[availability.weekday!]!.keys.contains(availabilityItem) {
                return AvailabilityPostResult.timeConflict
            } else {
                timeAvailabilityTable[availability.weekday!]![availabilityItem] = availability.rate
            }
        }
        timeAvailabilityEntries.append(availability)
        return AvailabilityPostResult.success
    }
    
    func post(pid: String, onCompletion callback: @escaping () -> Void) {
        var availabilityItemList: [[String: String]] = []
        for availabilityModel in timeAvailabilityEntries {
            availabilityItemList.append([
                "weekday": String(availabilityModel.weekday!.prefix(3)),
                "start": String(availabilityModel.start!),
                "end": String(availabilityModel.end!),
                "rate": String(availabilityModel.rate!)
            ])
        }
        let data = JSON(["pid": pid, "availabilityData": availabilityItemList])
        sendPostRequest(toURL: Configurations.API_ROOT + Configurations.API_URL.updateAvailability.rawValue, withData: data.rawString(String.Encoding.utf8, options: [])!) {
            (statusCode, responseData) in
            callback()
        }
    }
    
    func loadData(jsonData: JSON) {
        let dataArray = jsonData.arrayValue
        for entry in dataArray {
            let availabilityModel = TimeAvailabilityModel(jsonData: entry)
            if addAvailability(availability: availabilityModel) != .success {
                continue
            }
        }
    }
    
    func count() -> Int {
        return timeAvailabilityEntries.count
    }
    
    func getAvailabilityModel(at index: Int) -> TimeAvailabilityModel {
        return timeAvailabilityEntries[index]
    }

}
