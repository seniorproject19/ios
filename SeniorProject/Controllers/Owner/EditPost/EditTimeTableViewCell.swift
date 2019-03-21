//
//  EditTimeTableViewCell.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/20/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class EditTimeTableViewCell: UITableViewCell, UITextFieldDelegate {
    let timePicker = UIDatePicker()
    let timeFormatter = DateFormatter()
    var finishEditingHandler: ((String?) -> Void)? = nil
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        inputField.delegate = self
        timeFormatter.dateFormat = "h:mm a"
        timePicker.datePickerMode = .time
        timePicker.minuteInterval = 30
        timePicker.addTarget(self, action: #selector(timePickerChanged(_:)), for: .valueChanged)
        inputField.inputView = timePicker
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func timePickerChanged(_ sender: UIDatePicker){
        inputField.text = timeFormatter.string(from: sender.date)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        finishEditingHandler!(textField.text)
    }

}
