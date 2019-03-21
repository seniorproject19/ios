//
//  SidebarProfileTableViewCell.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/19/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class SidebarProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.lineBreakMode = .byWordWrapping
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
