//
//  ServerAccessModel.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 2/7/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit
import Alamofire

protocol ServerAccessModel {
    
    func sendGetRequest(toURL url: String, onCompletion completion: @escaping (Int, Data?) -> Void)
    func sendPostRequest(toURL url: String, withData data: String?, onCompletion completion: @escaping (Int, Data?) -> Void)
    func uploadImage(toURL url: String, image: UIImage, filename: String, forPost postId: String)
    func downloadImage(fromURL url: String, onCompletion callback: @escaping (UIImage) -> Void)
    func convertDateStringToMySQLDateString(dateString: String) -> String
    func convertMySQLDateStringToDateString(mySQLDateString: String) -> String

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
    
    func uploadImage(toURL url: String, image: UIImage, filename: String, forPost postId: String) {
        AF.upload(multipartFormData: {
            (multipartFormData) in
            if let imageData = image.jpegData(compressionQuality: 0.5) {
                multipartFormData.append(imageData, withName: "file", fileName: filename, mimeType: "image/jpeg")
            }
        }, to: url).response {
            (response) in
            print(response)
        }
    }
    
    func downloadImage(fromURL url: String, onCompletion callback: @escaping (UIImage) -> Void) {
        AF.download(url).responseData {
            (response) in
            if let data = response.result.value {
                let image = UIImage(data: data)
                if image != nil {
                    callback(image!)
                }
            }
        }
    }
    
    func convertDateStringToMySQLDateString(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: date!)
    }
    
    func convertMySQLDateStringToDateString(mySQLDateString: String) -> String {
        let dateString = String(mySQLDateString.split(separator: "T")[0])
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date!)
    }
    
}
