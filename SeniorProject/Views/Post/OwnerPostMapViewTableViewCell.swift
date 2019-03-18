//
//  OwnerPostMapViewTableViewCell.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/17/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit
import MapKit

class OwnerPostMapViewTableViewCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
