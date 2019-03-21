//
//  OwnerPostDescriptionTableViewCell.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/17/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class OwnerPostDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionContentLabel.lineBreakMode = .byWordWrapping
        self.selectionStyle = UITableViewCell.SelectionStyle.none

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
