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
                let jsonData = JSON(responseData)
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

}
