//
//  TimeSlotListTableViewController.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/2/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class TimeSlotListTableViewController: UITableViewController {
    
    var model: NewPostModel? = nil
    
    @IBAction func unwindToTimeSlotTableViewController(segue: UIStoryboardSegue) {
        tableView.reloadData()
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            if let model = model {
                return model.availabilityTableModel.count()
            }
        } else {
            return 1
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "timeSlotCell", for: indexPath) as! TimeSlotTableViewCell
            let weekday = model!.availabilityTableModel.getAvailabilityModel(at: indexPath.row).weekday
            let startTime = model!.availabilityTableModel.getAvailabilityModel(at: indexPath.row).startString
            let endTime = model!.availabilityTableModel.getAvailabilityModel(at: indexPath.row).endString
            cell.timeSlotsTimeLabel.text = weekday!.prefix(3) + " " + startTime! + " - " + endTime!
            cell.timeSlotsRateLabel.text = model!.availabilityTableModel.getAvailabilityModel(at: indexPath.row).rate?.description
            cell.isUserInteractionEnabled = false
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "postTableViewCell", for: indexPath)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            model?.postTimeAvailability {
                self.updateUIAsync {
                    self.performSegue(withIdentifier: "unwindToOwnerHomepageSegue", sender: self)
                }
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newAvailabilitySegue" {
            if let navigationController = segue.destination as? UINavigationController {
                if let destination = navigationController.viewControllers.first as? AddTimeSlotViewController {
                    destination.model = model
                }
            }
        }
    }

}
