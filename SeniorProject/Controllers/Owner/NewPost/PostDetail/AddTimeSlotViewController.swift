//
//  AddTimeSlotViewController.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/2/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class AddTimeSlotViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    
    var model: PostModel? = nil
    var availabilityModel = TimeAvailabilityModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        if segue.identifier == "showHourlyRateSegue" {
            if let destination = segue.destination as? PostRateViewController {
                destination.model = model
                destination.availabilityModel = availabilityModel
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userAddTimeSlotCell", for: indexPath) as! UserAddTimeSlotTableViewCell
            cell.inputLabel.text = "Select Day"
            cell.finishEditingHandler = updateDay
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userAddTimeTableViewCell", for: indexPath) as! UserAddTimeTableViewCell
            cell.label.text = "Start Time"
            cell.finishEditingHandler = updateStartTime
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userAddTimeTableViewCell", for: indexPath) as! UserAddTimeTableViewCell
            cell.label.text = "End Time"
            cell.finishEditingHandler = updateEndTime
            return cell
        }

    }

    func updateDay(_ day: String?) {
        self.availabilityModel.weekday = day
    }
    
    func updateStartTime(_ startTime: String?) {
        self.availabilityModel.startString = startTime
    }
    
    func updateEndTime(_ endTime: String?) {
        self.availabilityModel.endString = endTime
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
