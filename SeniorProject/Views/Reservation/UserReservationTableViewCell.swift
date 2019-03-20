//
//  UserReservationTableViewCell.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/19/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit
import MapKit

class UserReservationTableViewCell: UITableViewCell {

    @IBOutlet weak var reservationEntryView: UIView!
    @IBOutlet weak var timeRateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        reservationEntryView.layer.borderColor = UIColor(red: 0.9137, green: 0.9137, blue: 0.9137, alpha: 1.0).cgColor
        reservationEntryView.layer.borderWidth = 1.0
        reservationEntryView.layer.masksToBounds = true
        reservationEntryView.layer.cornerRadius = 4
        timeRateLabel.lineBreakMode = .byWordWrapping
        timeRateLabel.lineBreakMode = .byWordWrapping
        addressLabel.lineBreakMode = .byWordWrapping
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
