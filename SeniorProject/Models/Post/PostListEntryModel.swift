//
//  PostListEntryModel.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/17/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class PostListEntryModel: NSObject {
    
    let pid: String
    let title: String
    let address: String
    let longitude: Double
    let latitude: Double
    
    init(pid: String, title: String, address: String, longitude: Double, latitude: Double) {
        self.pid = pid
        self.title = title
        self.address = address
        self.longitude = longitude
        self.latitude = latitude
    }
    
    init(jsonData: JSON) {
        self.pid = jsonData["pid"].stringValue
        self.title = jsonData["title"].stringValue
        self.address = jsonData["address"].stringValue
        self.longitude = jsonData["longitude"].doubleValue
        self.latitude = jsonData["latitude"].doubleValue
    }

}
