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
    
    enum LoginResult {
        case success
        case wrongUsername
        case wrongPassword
        case serverError
    }
    
    enum AuthenticationClass: String {
        case user
        case owner
        case unauthorized
    }
    
    let authenticatedUserIdDefaultsKey = "authenticatedUser"
    let authenticationClassDefaultsKey = "authenticationClass"
    
    var authenticationStatus: AuthenticationClass {
        get {
            guard let status = UserDefaults.standard.value(forKey: authenticationClassDefaultsKey) as? String else {
                return AuthenticationClass.unauthorized
            }
            return AuthenticationClass(rawValue: status) ?? AuthenticationClass.unauthorized
        }
        set(status) {
            UserDefaults.standard.set(status.rawValue, forKey: authenticationClassDefaultsKey)
        }
    }
    
    var authenticatedUserId: String? {
        get {
            guard let uid = UserDefaults.standard.value(forKey: authenticatedUserIdDefaultsKey) as? String else {
                return nil
            }
            return uid
        }
        set(status) {
            UserDefaults.standard.set(status, forKey: authenticatedUserIdDefaultsKey)
        }
    }
    
    init() {
        self.user = nil;
    }
    
    func login(username: String, password: String, onCompletion callback: @escaping (LoginResult) -> Void) {
        let data = JSON(["username": username, "pwd": password])
        let apiURLString = Configurations.AUTH_ROOT + Configurations.AUTH_URL.login.rawValue
        sendPostRequest(toURL: apiURLString, withData: data.rawString(String.Encoding.utf8, options: [])!) {
            (statusCode, responseData) in
            let url = URL(string: apiURLString)
            let cookies = HTTPCookieStorage.shared.cookies(for: url!)
            self.storeCookies(cookies: cookies)
            if (statusCode != 200) {
                if (responseData != nil) {
                    let jsonData = JSON(responseData!)
                    let msg = jsonData["msg"].stringValue
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
                if (responseData != nil) {
                    let jsonData = JSON(responseData!)
                    let msg = jsonData["msg"].stringValue
                    self.loadUser(uid: msg) {
                        (succeeded) in
                        if succeeded {
                            callback(.success)
                        } else {
                            callback(.serverError)
                        }
                    }
                } else {
                    callback(.serverError)
                }
            }
        }
    }
    
    func loadUser(callback: @escaping (Bool) -> Void) {
        if let userId = authenticatedUserId {
            loadUser(uid: userId) {
                (result) in
                callback(result)
            }
        } else {
            callback(false)
        }
    }
    
    func loadUser(uid: String, onCompletion callback: @escaping (Bool) -> Void) {
        restoreCookies()
        sendGetRequest(toURL: Configurations.API_ROOT + Configurations.API_URL.getUser.rawValue) {
            (statusCode, data) in
            if (statusCode != 200 || data == nil) {
                callback(false)
            } else {
                self.user = UserModel(userData: data!)
                self.authenticatedUserId = uid
                self.authenticationStatus = self.user!.isOwner ? .owner : .user
                callback(true)
            }
        }
    }
    
}
