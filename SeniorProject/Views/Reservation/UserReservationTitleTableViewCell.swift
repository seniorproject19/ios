//
//  UserReservationTitleTableViewCell.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/19/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class UserReservationTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.lineBreakMode = .byWordWrapping
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
