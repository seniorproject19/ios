//
//  UserSelectTimeSlotTableViewCell.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/20/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class UserSelectTimeSlotTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    var finishEditingHandler: ((String?) -> Void)? = nil
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        inputTextField.delegate = self
        dateFormatter.dateFormat = "h:mm a"
        datePicker.datePickerMode = .time
        datePicker.minuteInterval = 30
        datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        inputTextField.inputView = datePicker
    }
    
    func setAsDayPicker() {
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let currentDate = Date()
        var dateComponents = DateComponents()
        let calendar = Calendar.init(identifier: .gregorian)
        dateComponents.day = 5
        let maxDate = calendar.date(byAdding: dateComponents, to: currentDate)
        datePicker.datePickerMode = .date
        datePicker.minimumDate = currentDate
        datePicker.maximumDate = maxDate
        inputTextField.inputView = datePicker
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        finishEditingHandler!(textField.text)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func datePickerChanged(_ sender: UIDatePicker){
        inputTextField.text = dateFormatter.string(from: sender.date)
    }

}
