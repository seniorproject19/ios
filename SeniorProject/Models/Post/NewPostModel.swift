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
    var datePosted: Date? = nil
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

}
