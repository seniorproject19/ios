//
//  PostImageScrollViewImageView.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/18/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class PostImageScrollViewImageView: UIView {
    
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: 228))
    
    init() {
        let screenWidth = UIScreen.main.bounds.width
        super.init(frame: CGRect(x: 0, y: 0, width: screenWidth - 32, height: 228))
        self.addSubview(imageView)
        self.bringSubviewToFront(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
