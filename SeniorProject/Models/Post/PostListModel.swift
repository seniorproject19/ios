//
//  PostListModel.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/17/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit
import MapKit

class PostListModel: ServerAccessModel, BaseModel {
    
    var entries = [PostListEntryModel]()
    
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
    
    func count() -> Int {
        return entries.count
    }
    
    func get(_ index: Int) -> PostListEntryModel {
        return entries[index]
    }
    
    enum PostListResult {
        case success
        case failure
    }
    
    func loadData(onCompletion callback: @escaping (PostListResult) -> Void) {
        sendGetRequest(toURL: Configurations.API_ROOT + Configurations.API_URL.getPostList.rawValue) {
            (statusCode, responseData) in
            if statusCode == 200 {
                let jsonData = JSON(responseData!)
                let listData = jsonData["data"].arrayValue
                for postEntry in listData {
                    self.entries.append(PostListEntryModel(jsonData: postEntry))
                }
                callback(.success)
            } else {
                callback(.failure)
            }
        }
    }
    
    func loadDataInRegion(topLeft: CLLocationCoordinate2D, bottomRight: CLLocationCoordinate2D, onCompletion callback: @escaping (PostListResult) -> Void) {
        let data = JSON([
            "top_left_long": topLeft.longitude,
            "top_left_lat": topLeft.latitude,
            "bottom_right_long": bottomRight.longitude,
            "bottom_right_lat": bottomRight.latitude
        ])
        sendPostRequest(toURL: Configurations.API_ROOT + Configurations.API_URL.getPostListInRegion.rawValue, withData: data.rawString(String.Encoding.utf8, options: [])!) {
            (statusCode, responseData) in
            self.entries = [PostListEntryModel]()
            if statusCode == 200 {
                let jsonData = JSON(responseData!)
                print(jsonData)
                let listData = jsonData["data"].arrayValue
                for postEntry in listData {
                    self.entries.append(PostListEntryModel(jsonData: postEntry))
                }
                callback(.success)
            } else {
                callback(.failure)
            }
        }
    }
    
    func loadTestData() {
        self.entries.append(PostListEntryModel(pid: "1", title: "Test Data 1", address: "747 Howard St, San Francisco, CA 94103, United States", longitude: -122.400969, latitude: 37.783558))
        self.entries.append(PostListEntryModel(pid: "2", title: "Test Data 2", address: "900 Market St, San Francisco, CA 94102, United States", longitude: -122.408784, latitude: 37.784280))
        self.entries.append(PostListEntryModel(pid: "2", title: "Test Data 3", address: "845 Market St, San Francisco, CA 94103, United States", longitude: -122.405672, latitude: 37.783395))
    }

}
