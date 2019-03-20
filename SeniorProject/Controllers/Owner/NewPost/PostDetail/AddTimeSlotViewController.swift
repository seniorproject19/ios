//
//  AddTimeSlotViewController.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/2/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class AddTimeSlotViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource{
    
    let weekDayPickerOptions = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var model: PostModel? = nil
    var availabilityModel = TimeAvailabilityModel()


    @IBOutlet weak var selectDayTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    /*
    lazy var datePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.minuteInterval = 30
        picker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        return picker
    }()
    */
    //let datePicker = UIDatePicker()
    let endTimePicker = UIDatePicker()
    let startTimePicker = UIDatePicker()
    let timeFormatter = DateFormatter()
    //let dateFormatter = DateFormatter()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeFormatter.dateFormat = "h:mm a"
        //dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let dayPicker = UIPickerView()
        dayPicker.delegate = self
        selectDayTextField.inputView = dayPicker
        /*
        let currentDate = Date()
        var dateComponents = DateComponents()
        let calendar = Calendar.init(identifier: .gregorian)
        dateComponents.day = 5
        let maxDate = calendar.date(byAdding: dateComponents, to: currentDate)
       
        datePicker.datePickerMode = .date
        datePicker.minimumDate = currentDate
        datePicker.maximumDate = maxDate
        datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
       */
        startTimePicker.datePickerMode = .time
        startTimePicker.minuteInterval = 30
        startTimePicker.addTarget(self, action: #selector(startTimePickerChanged(_:)), for: .valueChanged)

        endTimePicker.datePickerMode = .time
        endTimePicker.minuteInterval = 30
        endTimePicker.addTarget(self, action: #selector(endTimePickerChanged(_:)), for: .valueChanged)
        
        startTimeTextField.inputView = startTimePicker
        endTimeTextField.inputView = endTimePicker
       // selectDayTextField.inputView = datePicker


        // Do any additional setup after loading the view.
    }

    @objc func startTimePickerChanged(_ sender: UIDatePicker){
        startTimeTextField.text = timeFormatter.string(from: sender.date)
    }
    
    @objc func endTimePickerChanged(_ sender: UIDatePicker){
        endTimeTextField.text = timeFormatter.string(from: sender.date)
    }
    /*
    @objc func datePickerChanged(_ sender: UIDatePicker){
        selectDayTextField.text = dateFormatter.string(from: sender.date)
    }
    */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weekDayPickerOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weekDayPickerOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectDayTextField.text = weekDayPickerOptions[row]
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
/*
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField.tag == 2){
            timePicker.isHidden = true
            weekdayPicker.isHidden = false
        } else {
            timePicker.isHidden = false
            weekdayPicker.isHidden = true
        }
        return true
    }
    */

    /*
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (textField.tag == 3) {
            
            let dateFormatr = DateFormatter()
            dateFormatr.dateFormat = "h:mm a"
            let strDate = dateFormatr.string(from: (timePicker?.date)!)
            textField.text = strDate
            print("3 ended")
            
        } else if (textField.tag == 4) {
            let dateFormatr = DateFormatter()
            dateFormatr.dateFormat = "h:mm a"
            let strDate = dateFormatr.string(from: (timePicker?.date)!)
            textField.text = strDate
            print("4 ended")
        }
        return true
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        availabilityModel.weekday = selectDayTextField.text
        availabilityModel.startString = startTimeTextField.text
        availabilityModel.endString = endTimeTextField.text
        if segue.identifier == "showHourlyRateSegue" {
            if let destination = segue.destination as? PostRateViewController {
                destination.model = model
                destination.availabilityModel = availabilityModel
            }
        }
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
