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
    let email: String
    let isOwner: Bool
    
    init(uid: String, email: String, isOwner: Bool) {
        self.uid = uid
        self.email = email
        self.isOwner = isOwner
    }
    
    init(userData: Data) {
        let jsonData = JSON(userData)
        self.uid = jsonData["uid"].string!
        self.email = jsonData["email"].string!
        self.isOwner = jsonData["isOwner"].bool!
    }
    
}
