//
//  UserSelectTimeViewController.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/14/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class UserSelectTimeViewController: UIViewController {
    
    var currentUser: CurrentUserModel? = nil
    let datePicker = UIDatePicker()
    let endTimePicker = UIDatePicker()
    let startTimePicker = UIDatePicker()
    let timeFormatter = DateFormatter()
    let dateFormatter = DateFormatter()

    
    @IBOutlet weak var selectDayTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
  
    
    @IBAction func NextButtonClicked(_ sender: Any) {
        print(selectDayTextField.text ?? "N/A"," ",startTimeTextField.text ?? "N/A" , " ", endTimeTextField.text ?? "N/A")
        print("Hi \n")
    }
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserMapViewSegue" {
            let destination = segue.destination as! MapViewController
            let destinationModel = PostListModel()
            destinationModel.requestedDate = selectDayTextField.text
            destinationModel.requestedStartHour = startTimeTextField.text
            destinationModel.requestedEndHour = endTimeTextField.text
            destination.postList = destinationModel
            destination.currentUser = currentUser
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeFormatter.dateFormat = "h:mm a"
        dateFormatter.dateFormat = "MM/dd/yyyy"
        


        
        let currentDate = Date()
        var dateComponents = DateComponents()
        let calendar = Calendar.init(identifier: .gregorian)
        dateComponents.day = 5
        let maxDate = calendar.date(byAdding: dateComponents, to: currentDate)
        
        datePicker.datePickerMode = .date
        datePicker.minimumDate = currentDate
        datePicker.maximumDate = maxDate
        datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        
        startTimePicker.datePickerMode = .time
        startTimePicker.minuteInterval = 30
        startTimePicker.addTarget(self, action: #selector(startTimePickerChanged(_:)), for: .valueChanged)
        
        endTimePicker.datePickerMode = .time
        endTimePicker.minuteInterval = 30
        endTimePicker.addTarget(self, action: #selector(endTimePickerChanged(_:)), for: .valueChanged)
        
        startTimeTextField.inputView = startTimePicker
        endTimeTextField.inputView = endTimePicker
        selectDayTextField.inputView = datePicker
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func startTimePickerChanged(_ sender: UIDatePicker){
        startTimeTextField.text = timeFormatter.string(from: sender.date)
    }
    
    @objc func endTimePickerChanged(_ sender: UIDatePicker){
        endTimeTextField.text = timeFormatter.string(from: sender.date)
    }
    
    @objc func datePickerChanged(_ sender: UIDatePicker){
        selectDayTextField.text = dateFormatter.string(from: sender.date)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
