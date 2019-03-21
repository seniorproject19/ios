//
//  EditAddTimeSlotViewController.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/18/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class EditAddTimeSlotViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        if segue.identifier == "editShowHourlyRateSegue" {
            if let destination = segue.destination as? EditPostRateViewController {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "editTimeSlotTableViewCell", for: indexPath) as! EditTimeSlotTableViewCell
            cell.label.text = "Select Day"
            cell.finishEditingHandler = updateDay
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "editTimeTableViewCell", for: indexPath) as! EditTimeTableViewCell
            cell.label.text = "Start Time"
            cell.finishEditingHandler = updateStartTime
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "editTimeTableViewCell", for: indexPath) as! EditTimeTableViewCell
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
    
}
