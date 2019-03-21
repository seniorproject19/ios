//
//  UserSelectTimeViewController.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/14/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit
import SideMenu

class UserSelectTimeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let destinationModel = PostListModel()
    var currentUser: CurrentUserModel? = nil
  
    /*
    @IBAction func NextButtonClicked(_ sender: Any) {
        print(selectDayTextField.text ?? "N/A"," ",startTimeTextField.text ?? "N/A" , " ", endTimeTextField.text ?? "N/A")
        print("Hi \n")
    }
    
 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        view.endEditing(true)
        if segue.identifier == "showUserMapViewSegue" {
            let destination = segue.destination as! MapViewController
            destination.postList = destinationModel
            destination.currentUser = currentUser
        } else if segue.identifier == "showSidebarFromDateTimePickerSegue" {
            let destination = segue.destination as! UISideMenuNavigationController
            let destinationView = destination.viewControllers.first as! UserSidebarTableViewController
            destinationView.currentUser = currentUser
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SideMenuManager.default.menuFadeStatusBar = false
        
        if currentUser == nil {
            currentUser = CurrentUserModel()
            currentUser?.loadUser {
                (succeeded) in
                if !succeeded {
                    self.updateUIAsync {
                        let destination = self.storyboard?.instantiateViewController(withIdentifier: "appHomePage") as! LoginViewController
                        self.navigationController?.pushViewController(destination, animated: true)
                    }
                }
            }
        }
        
    }
    


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userSelectTimeSlotTableViewCell", for: indexPath) as! UserSelectTimeSlotTableViewCell
            cell.label.text = "Select Day"
            cell.setAsDayPicker()
            cell.finishEditingHandler = updateDay
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userSelectTimeSlotTableViewCell", for: indexPath) as! UserSelectTimeSlotTableViewCell
            cell.label.text = "Start Time"
            cell.finishEditingHandler = updateStartTime
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userSelectTimeSlotTableViewCell", for: indexPath) as! UserSelectTimeSlotTableViewCell
            cell.label.text = "End Time"
            cell.finishEditingHandler = updateEndTime
            return cell
        }
        
    }
    
    func updateDay(_ day: String?) {
        self.destinationModel.requestedDate = day
    }
    
    func updateStartTime(_ startTime: String?) {
        self.destinationModel.requestedStartHour = startTime
    }
    
    func updateEndTime(_ endTime: String?) {
        self.destinationModel.requestedEndHour = endTime
    }
}
