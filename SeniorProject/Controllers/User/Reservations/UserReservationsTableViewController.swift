//
//  UserReservationsTableViewController.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/19/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit
import SideMenu
import MapKit

class UserReservationsTableViewController: UITableViewController {
    
    var currentUser: CurrentUserModel? = nil
    var reservationList: ReservationListModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = UIColor.clear
        
        self.setup()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func setup() {
        reservationList?.loadData {
            (result) in
            self.updateUIAsync {
                print("DATA RELOADED")
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let currentReservationsCount = reservationList?.currentReservations?.count ?? 0
        let pastReservationsCount = reservationList?.pastReservations?.count ?? 0
        let categoryLabelCount = (currentReservationsCount == 0 ? 0 : 1) + (pastReservationsCount == 0 ? 0 : 1)
        print("CNT" + String(currentReservationsCount + pastReservationsCount + categoryLabelCount))
        return currentReservationsCount + pastReservationsCount + categoryLabelCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let currentReservationsCount = reservationList?.currentReservations?.count ?? 0
        
        if currentReservationsCount == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "reservationTitleCell", for: indexPath) as! UserReservationTitleTableViewCell
                cell.titleLabel.text = "Past Reservations"
                return cell
            } else {
                let reservationModel = reservationList?.pastReservations?[indexPath.row - 1]
                let cell = tableView.dequeueReusableCell(withIdentifier: "reservationEntryCell", for: indexPath) as! UserReservationTableViewCell
                cell.latitude = reservationModel?.latitude
                cell.longitude = reservationModel?.longitude
                cell.placeAnnotation()
                cell.titleLabel.text = reservationModel?.title
                cell.addressLabel.text = reservationModel?.address
                let date = reservationModel?.requestedDate ?? ""
                let start = reservationModel?.requestedStartHour ?? ""
                let end = reservationModel?.requestedEndHour ?? ""
               
                cell.timeRateLabel.text = date + " " + start + " - " + end
                return cell
            }
        } else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "reservationTitleCell", for: indexPath) as! UserReservationTitleTableViewCell
                cell.titleLabel.text = "Current Reservations"
                return cell
            } else if indexPath.row <= currentReservationsCount {
                let reservationModel = reservationList?.currentReservations?[indexPath.row - 1]
                let cell = tableView.dequeueReusableCell(withIdentifier: "reservationEntryCell", for: indexPath) as! UserReservationTableViewCell
                cell.latitude = reservationModel?.latitude
                cell.longitude = reservationModel?.longitude
                cell.placeAnnotation()
                cell.titleLabel.text = reservationModel?.title
                cell.addressLabel.text = reservationModel?.address
                let date = reservationModel?.requestedDate ?? ""
                let start = reservationModel?.requestedStartHour ?? ""
                let end = reservationModel?.requestedEndHour ?? ""
                cell.timeRateLabel.text = date + " " + start + " - " + end
                return cell
            } else if indexPath.row == currentReservationsCount + 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "reservationTitleCell", for: indexPath) as! UserReservationTitleTableViewCell
                cell.titleLabel.text = "Past Reservations"
                return cell
            } else {
                let reservationModel = reservationList?.pastReservations?[indexPath.row - currentReservationsCount - 2]
                let cell = tableView.dequeueReusableCell(withIdentifier: "reservationEntryCell", for: indexPath) as! UserReservationTableViewCell
                cell.titleLabel.text = reservationModel?.title
                cell.addressLabel.text = reservationModel?.address
                let date = reservationModel?.requestedDate ?? ""
                let start = reservationModel?.requestedStartHour ?? ""
                let end = reservationModel?.requestedEndHour ?? ""
                cell.timeRateLabel.text = date + " " + start + " - " + end
                return cell
            }
        }

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentReservationsCount = reservationList?.currentReservations?.count ?? 0
        let pastReservationsCount = reservationList?.pastReservations?.count ?? 0
        let categoryLabelCount = (currentReservationsCount == 0 ? 0 : 1) + (pastReservationsCount == 0 ? 0 : 1)
        if indexPath.row != 0 && indexPath.row <= currentReservationsCount {
            let reservationModel = reservationList?.currentReservations?[indexPath.row - 1]
            reservationModel?.postModel?.loadData {
                (result) in
                let destination = self.storyboard?.instantiateViewController(withIdentifier: "reservationDetailViewNavigationController") as! UINavigationController
                let destinationView = destination.viewControllers.first as! ReservationDetailTableViewController
                destinationView.reservationModel = reservationModel
                self.present(destination, animated: true, completion: nil)
            }
        } else if indexPath.row != 0 {
            if currentReservationsCount == 0 || (currentReservationsCount != 0 && indexPath.row != currentReservationsCount + 1) {
                let reservationModel = reservationList?.pastReservations?[indexPath.row - currentReservationsCount - categoryLabelCount]
                let destination = self.storyboard?.instantiateViewController(withIdentifier: "reservationDetailViewNavigationController") as! UINavigationController
                let destinationView = destination.viewControllers.first as! ReservationDetailTableViewController
                destinationView.pastReservationModel = reservationModel
                self.present(destination, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func unwindToUserReservationsViewController(segue: UIStoryboardSegue) {
        self.setup()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSidebarFromReservationTableSegue" {
            let destination = segue.destination as! UISideMenuNavigationController
            let destinationView = destination.viewControllers.first as! UserSidebarTableViewController
            destinationView.currentUser = currentUser
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

}
