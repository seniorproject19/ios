//
//  NewUserModel.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/1/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class NewUserModel: ServerAccessModel {
    
    var username: String? = nil
    var email: String? = nil
    var password: String? = nil
    var confirmPassword: String? = nil
    var isOwner: Bool? = nil
    
    enum RegisterResult {
        case success
        case illegalInput(msg: String)
        case serverError
    }
    
    func validate() -> String? {
        // TODO: validate inputs
        if username != nil {
            return "illegal username"
        }
        if email != nil {
            return "illegal email"
        }
        if password != nil {
            return "illegal password"
        }
        if password != confirmPassword {
            return "password mismatch"
        }
        return nil
    }
    
    func register(onCompletion callback: @escaping (RegisterResult) -> Void) {
        let validateResult = validate()
        if validateResult != nil {
            callback(RegisterResult.illegalInput(msg: validateResult!))
        } else {
            let data = JSON(["username": username!, "email": email!, "password": password!, "isOwner": isOwner!])
            let apiURLString = Configurations.AUTH_ROOT + "/register"
            sendPostRequest(toURL: apiURLString, withData: data.rawString(String.Encoding.utf8, options: [])!) {
                (statusCode, responseData) in
                if (statusCode != 200) {
                    callback(.serverError)
                } else {
                    callback(.success)
                }
            }
        }
    }

}
