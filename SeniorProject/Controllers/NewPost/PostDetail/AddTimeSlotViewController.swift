//
//  AddTimeSlotViewController.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/2/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class AddTimeSlotViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate{
   
    

    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var weekdayPicker: UIPickerView!
    
    @IBOutlet weak var selectDayTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!

    @IBOutlet weak var endTimeButton: UIButton!
    @IBOutlet weak var startTimeButton: UIButton!
    @IBOutlet weak var selectDayButton: UIButton!
    
    let weekDayPickerOptions = ["Monday","Tuesday","Wednesday","Thursday","Friday", "Saturday", "Sunday"]
    override func viewDidLoad() {
        super.viewDidLoad()

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
