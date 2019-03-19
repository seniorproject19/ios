//
//  PostListModel.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/17/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class PostListModel: ServerAccessModel {
    
    var entries = [PostListEntryModel]()
    
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
    
    func loadDataInRegion(longitude: Double, latitude: Double, onCompletion callback: @escaping (PostListResult) -> Void) {
        sendGetRequest(toURL: Configurations.API_ROOT + Configurations.API_URL.getPostListInRegion.rawValue) {
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
    
    func loadTestData() {
        self.entries.append(PostListEntryModel(pid: "1", title: "Test Data 1", address: "747 Howard St, San Francisco, CA 94103, United States", longitude: -122.400969, latitude: 37.783558))
        self.entries.append(PostListEntryModel(pid: "2", title: "Test Data 2", address: "900 Market St, San Francisco, CA 94102, United States", longitude: -122.408784, latitude: 37.784280))
        self.entries.append(PostListEntryModel(pid: "2", title: "Test Data 3", address: "845 Market St, San Francisco, CA 94103, United States", longitude: -122.405672, latitude: 37.783395))
    }

}
