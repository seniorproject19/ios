//
//  AddTimeSlotViewController.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/2/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class AddTimeSlotViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
   

    

    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var weekdayPicker: UIPickerView!
    
    @IBOutlet weak var selectDayTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!

    @IBOutlet weak var endTimeButton: UIButton!
    @IBOutlet weak var startTimeButton: UIButton!
    @IBOutlet weak var selectDayButton: UIButton!

    // Now we specify the display format, e.g. "27-08-2015
    
    let weekDayPickerOptions = ["Monday","Tuesday","Wednesday","Thursday","Friday", "Saturday", "Sunday"]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        timePicker.tag = 0
        weekdayPicker.tag = 1
        selectDayTextField.tag = 2
        startTimeTextField.tag = 3
        endTimeTextField.tag = 4
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
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weekDayPickerOptions[row]
    }
    

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField.tag == 2){
            timePicker.isHidden = true
            weekdayPicker.isHidden = false
        }
        else {
            timePicker.isHidden = false
            weekdayPicker.isHidden = true
        }
        return true
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectDayTextField.text = weekDayPickerOptions[row]
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (textField.tag == 3){
            
            let dateFormatr = DateFormatter()
            dateFormatr.dateFormat = "h:mm a"
            let strDate = dateFormatr.string(from: (timePicker?.date)!)
            textField.text = strDate
            print("3 ended")
            
        }
        else if (textField.tag == 4){
            let dateFormatr = DateFormatter()
            dateFormatr.dateFormat = "h:mm a"
            let strDate = dateFormatr.string(from: (timePicker?.date)!)
            textField.text = strDate
            print("4 ended")
        }
        return true
    }

        
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
