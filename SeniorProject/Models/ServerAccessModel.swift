//
//  ServerAccessModel.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 2/7/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

protocol ServerAccessModel {
    
    func sendGetRequest(toURL url: String, onCompletion completion: @escaping (Int, Data?) -> Void)
    func sendPostRequest(toURL url: String, withData data: String?, onCompletion completion: @escaping (Int, Data?) -> Void)

}

extension ServerAccessModel {
    
    func sendGetRequest(toURL url: String, onCompletion completion: @escaping (Int, Data?) -> Void) {
        let url = URL(string: url)
        
        let task = URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            if let httpResponse = httpResponse {
                completion(httpResponse.statusCode, data)
            }
        }
        
        task.resume()
    }
    
    func sendPostRequest(toURL url: String, withData data: String?, onCompletion completion: @escaping (Int, Data?) -> Void) {
        let url = URL(string: url)
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let data = data {
            request.httpBody = data.data(using: String.Encoding.utf8)
        }
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            if let httpResponse = httpResponse {
                completion(httpResponse.statusCode, data)
            }
        }
        
        task.resume()
    }
    
}