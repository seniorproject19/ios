//
//  UserAddTimeTableViewCell.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/20/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class UserAddTimeTableViewCell: UITableViewCell, UITextFieldDelegate {
    let timePicker = UIDatePicker()
    let timeFormatter = DateFormatter()
    var finishEditingHandler: ((String?) -> Void)? = nil
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        inputTextField.delegate = self
        // Initialization code
        timeFormatter.dateFormat = "h:mm a"
   
        timePicker.datePickerMode = .time
        timePicker.minuteInterval = 30
        timePicker.addTarget(self, action: #selector(timePickerChanged(_:)), for: .valueChanged)
        inputTextField.inputView = timePicker
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func timePickerChanged(_ sender: UIDatePicker){
        inputTextField.text = timeFormatter.string(from: sender.date)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        finishEditingHandler!(textField.text)
    }


}
