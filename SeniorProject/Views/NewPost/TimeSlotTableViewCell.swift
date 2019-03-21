//
//  TimeSlotTableViewCell.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/15/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class TimeSlotTableViewCell: UITableViewCell {

    @IBOutlet weak var timeSlotsTimeLabel: UILabel!
    @IBOutlet weak var timeSlotsRateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
