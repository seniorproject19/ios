//
//  PostRateViewController.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/10/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class PostRateViewController: UIViewController {
    
    var model: PostModel? = nil
    var availabilityModel: TimeAvailabilityModel? = nil
    
    @IBOutlet weak var RateLabel: UILabel!
    @IBOutlet weak var rateSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        RateLabel.text = "$, \(rateSlider.value) per hour"
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        if let availabilityModel = availabilityModel {
            availabilityModel.rate = Double(rateSlider.value)
            if model?.availabilityTableModel.addAvailability(availability: availabilityModel) == .timeConflict {
                showAlert(withTitle: "Error", message: "The time you entered is in conflict with another time you entered before. Please choose another time or remove an existing time.")
            } else {
                performSegue(withIdentifier: "unwindToTimeSlotTable", sender: self)
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
