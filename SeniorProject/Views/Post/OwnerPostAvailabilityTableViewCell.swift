//
//  OwnerPostAvailabilityTableViewCell.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/18/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class OwnerPostAvailabilityTableViewCell: UITableViewCell {

    @IBOutlet weak var availabilityContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.availabilityContentLabel.lineBreakMode = .byWordWrapping
        self.selectionStyle = UITableViewCell.SelectionStyle.none

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
