//
//  Configurations.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 2/7/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class Configurations: NSObject {
    
    static let SERVER_ROOT = "http://localhost:3000"
    
    static let AUTH_ROOT = SERVER_ROOT + "/auth"
    static let API_ROOT = SERVER_ROOT + "/api"
    
    enum AUTH_URL: String {
        case register = "/register"
        case login = "/login"
    }
    
    enum API_URL: String {
        case getUser =  "/user"
        case newPost = "/post/new"
        case uploadImage = "/upload/images/"
        case updateAvailability = "/post/availability"
        case getPostList = "/post/get_list"
    }

}
