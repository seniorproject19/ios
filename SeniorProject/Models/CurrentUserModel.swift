//
//  CurrentUserModel.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 2/14/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class CurrentUserModel: ServerAccessModel, LocalStorageModel {
    
    var user: UserModel?
    
    init() {
        self.user = nil;
    }
    
    enum LoginResult {
        case success
        case wrongUsername
        case wrongPassword
        case serverError
    }
    
    func login(username: String, password: String, onCompletion callback: @escaping (LoginResult) -> Void) {
        let data = JSON(["username": username, "pwd": password])
        let apiURLString = Configurations.AUTH_ROOT + "/login"
        sendPostRequest(toURL: apiURLString, withData: data.rawString(String.Encoding.utf8, options: [])!) {
            (statusCode, responseData) in
            let url = URL(string: apiURLString)
            let cookies = HTTPCookieStorage.shared.cookies(for: url!)
            self.storeCookies(cookies: cookies)
            if (statusCode != 200) {
                if (responseData != nil) {
                    let jsonData = JSON(responseData!)
                    let msg = jsonData["msg"].string
                    if (msg == "incorrect_password") {
                        callback(.wrongPassword)
                    } else if (msg == "username_not_found") {
                        callback(.wrongUsername)
                    } else {
                        callback(.serverError)
                    }
                } else {
                    callback(.serverError)
                }
            } else {
                callback(.success)
            }
        }
    }
    
    func loadUser(uid: String, onCompletion callback: @escaping (Bool) -> Void) {
        restoreCookies()
        sendGetRequest(toURL: Configurations.API_ROOT + "/user") {
            (statusCode, data) in
            if (statusCode != 200 || data == nil) {
                callback(false)
            } else {
                self.user = UserModel(userData: data!)
                callback(true)
            }
        }
    }
    
}
