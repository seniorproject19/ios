//
//  CurrentReservationsDetailViewTableViewCell.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/20/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class CurrentReservationsDetailViewTableViewCell: UITableViewCell {

    @IBOutlet weak var timeTextLabel: UILabel!
    @IBOutlet weak var plateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
