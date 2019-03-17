//
//  UserSelectTimeViewController.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/14/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class UserSelectTimeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var selectDayTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var weekdayPicker: UIPickerView!
    @IBOutlet weak var timePicker: UIDatePicker!
    let weekDayPickerOptions = ["Monday","Tuesday","Wednesday","Thursday","Friday", "Saturday", "Sunday"]
    @IBAction func NextButtonClicked(_ sender: Any) {
        print(selectDayTextField.text ?? "N/A"," ",startTimeTextField.text ?? "N/A" , " ", endTimeTextField.text ?? "N/A")
        print("Hi \n")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.tag = 5
        weekdayPicker.tag = 6
        selectDayTextField.tag = 7
        startTimeTextField.tag = 8
        endTimeTextField.tag = 9
        timePicker.isHidden = true
        weekdayPicker.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weekDayPickerOptions.count
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weekDayPickerOptions[row]
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField.tag == 7){
            timePicker.isHidden = true
            weekdayPicker.isHidden = false
        } else {
            timePicker.isHidden = false
            weekdayPicker.isHidden = true
        }
        return true
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectDayTextField.text = weekDayPickerOptions[row]
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (textField.tag == 8) {
            
            let dateFormatr = DateFormatter()
            dateFormatr.dateFormat = "h:mm a"
            let strDate = dateFormatr.string(from: (timePicker?.date)!)
            textField.text = strDate
            
        } else if (textField.tag == 9) {
            let dateFormatr = DateFormatter()
            dateFormatr.dateFormat = "h:mm a"
            let strDate = dateFormatr.string(from: (timePicker?.date)!)
            textField.text = strDate
        }
        return true
    }
}
