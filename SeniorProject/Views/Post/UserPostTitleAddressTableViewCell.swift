//
//  UserPostTitleAddressTableViewCell.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/19/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class UserPostTitleAddressTableViewCell: UITableViewCell {
    
    var confirmHandler: (() -> Void)? = nil

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var plateNumberLabel: UILabel!
    @IBOutlet weak var selectedTimeLabel: UILabel!
    @IBOutlet weak var reserveButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        confirmButton.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func reserveButtonClicked(_ sender: Any) {
        reserveButton.isHidden = true
        confirmButton.isHidden = false
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        confirmHandler!()
    }
    
}
