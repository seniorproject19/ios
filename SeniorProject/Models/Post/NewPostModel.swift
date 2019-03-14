//
//  NewPostModel.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/2/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class NewPostModel: ServerAccessModel {
    
    var postBy: UserModel? = nil
    var datePosted: String? = nil
    var title: String? = nil
    var description: String? = nil
    var longitude: Double? = nil
    var latitude: Double? = nil
    var address: String? = nil
    var images: [UIImage]? = nil
    
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
            let jsonData = JSON(responseData)
            let postId = jsonData["msg"].stringValue
            let timestamp = NSDate().timeIntervalSince1970
            if statusCode == 200 && self.images != nil {
                for i in 0..<self.images!.count {
                    let filename = postId + "_" + String(Int(timestamp)) + "_" + String(i) + ".jpg"
                    self.uploadImage(toURL: Configurations.API_ROOT + Configurations.API_URL.uploadImage.rawValue + postId, image: self.images![i], filename: filename, forPost: postId)
                }
            }
        }
    }

}
