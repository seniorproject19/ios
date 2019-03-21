//
//  UserModel.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 2/7/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class UserModel: ServerAccessModel, LocalStorageModel {
    
    let uid: String
    let username: String
    let email: String
    let isOwner: Bool
    let plate: String
    var balance: Double
    
    init(uid: String, username: String, email: String, isOwner: Bool, plate: String, balance: Double) {
        self.uid = uid
        self.username = username
        self.email = email
        self.isOwner = isOwner
        self.plate = plate
        self.balance = balance
    }
    
    init(userData: Data) {
        let jsonData = JSON(userData)
        self.uid = jsonData["uid"].stringValue
        self.username = jsonData["username"].stringValue
        self.email = jsonData["email"].stringValue
        self.isOwner = jsonData["is_owner"].boolValue
        self.plate = jsonData["vehicle_info"].stringValue
        self.balance = jsonData["balance"].doubleValue
    }
    
}
