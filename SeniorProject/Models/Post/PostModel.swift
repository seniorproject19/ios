//
//  NewPostModel.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/2/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class PostModel: ServerAccessModel {
    
    var pid: String? = nil
    var postBy: UserModel? = nil
    var datePosted: String? = nil
    var title: String? = nil
    var description: String? = nil
    var longitude: Double? = nil
    var latitude: Double? = nil
    var address: String? = nil
    var images: [UIImage]? = nil
    var imagePaths: [String]? = nil
    var availabilityTableModel = TimeAvailabilityTableModel()
    
    func addImages(image: UIImage) {
        if images == nil {
            images = [UIImage]()
        }
        images?.append(image)
    }
    
    func addImages(image: [UIImage]) {
        if images == nil {
            images = image
        } else {
            images?.append(contentsOf: image)
        }
    }
    
    func countImages() -> Int {
        if let images = images {
            return images.count
        }
        return 0
    }
    
    func getImage(atIndex index: Int) -> UIImage? {
        if let images = images {
            return images[index]
        }
        return nil
    }
    
    enum LoadPostResult {
        case success
        case failure
    }
    
    func loadData(onCompletion callback: @escaping (LoadPostResult) -> Void) {
        sendGetRequest(toURL: Configurations.API_ROOT + Configurations.API_URL.getPost.rawValue + pid!) {
            (statusCode, responseData) in
            if statusCode == 200 {
                let jsonData = JSON(responseData!)
                self.title = jsonData["title"].stringValue
                self.datePosted = jsonData["date_posted"].stringValue
                self.description = jsonData["description"].stringValue
                self.longitude = jsonData["longitude"].doubleValue
                self.latitude = jsonData["latitude"].doubleValue
                self.address = jsonData["address"].stringValue
                self.availabilityTableModel.loadData(jsonData: jsonData["availability"])
                self.sendGetRequest(toURL: Configurations.API_ROOT + Configurations.API_URL.getPostImagePathsList.rawValue + self.pid!) {
                    (statusCode, responseData) in
                    if (statusCode == 200) {
                        let jsonData = JSON(responseData!)
                        let pathsArray = jsonData["file_paths"].arrayValue
                        self.imagePaths = [String]()
                        for filePath in pathsArray {
                            self.imagePaths?.append(filePath.stringValue)
                        }
                    }
                    callback(.success)
                }
            } else {
                callback(.failure)
            }
        }
    }
    
    func post(onCompletion callback: @escaping () -> Void) {
        let data = JSON([
            "date_posted": datePosted!,
            "address_1": address!,
            "title": title!,
            "description": description!,
            "longitude": longitude!,
            "latitude": latitude!
        ])
        sendPostRequest(toURL: Configurations.API_ROOT + Configurations.API_URL.newPost.rawValue, withData: data.rawString(String.Encoding.utf8, options: [])!) {
            (statusCode, responseData) in
            let jsonData = JSON(responseData!)
            let postId = jsonData["msg"].stringValue
            let timestamp = NSDate().timeIntervalSince1970
            if statusCode == 200 && self.images != nil {
                for i in 0..<self.images!.count {
                    let filename = postId + "_" + String(Int(timestamp)) + "_" + String(i) + ".jpg"
                    self.uploadImage(toURL: Configurations.API_ROOT + Configurations.API_URL.uploadImage.rawValue + postId, image: self.images![i], filename: filename, forPost: postId)
                }
            }
            self.pid = postId
            callback()
        }
    }
    
    func update(onCompletion callback: @escaping () -> Void) {
        let data = JSON([
            "pid": pid!,
            "title": title!,
            "description": description!,
        ])
        sendPostRequest(toURL: Configurations.API_ROOT + Configurations.API_URL.updatePost.rawValue, withData: data.rawString(String.Encoding.utf8, options: [])!) {
            (statusCode, responseData) in
            let postId = self.pid
            let timestamp = NSDate().timeIntervalSince1970
            if statusCode == 200 && self.images != nil {
                for i in self.imagePaths!.count..<self.images!.count {
                    let filename = postId! + "_" + String(Int(timestamp)) + "_" + String(i) + ".jpg"
                    self.uploadImage(toURL: Configurations.API_ROOT + Configurations.API_URL.uploadImage.rawValue + postId!, image: self.images![i], filename: filename, forPost: postId!)
                }
            }
            self.pid = postId
            callback()
        }
    }
    
    func getImageFromServer(at path: String, onCompletion callback: @escaping (UIImage) -> Void) {
        downloadImage(fromURL: Configurations.SERVER_ROOT + path) {
            (image) in
            if self.images == nil {
                self.images = [UIImage]()
            }
            self.images!.append(image)
            callback(image)
        }
    }
    
    func postTimeAvailability(onCompletion callback: @escaping () -> Void) {
        availabilityTableModel.post(pid: pid!) {
            callback()
        }
    }

}
