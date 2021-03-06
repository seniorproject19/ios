//
//  OwnerCurrentReservationsListTableViewController.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/20/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit
import SideMenu

class OwnerCurrentReservationsListTableViewController: UITableViewController {
    
    var currentUser: CurrentUserModel? = nil
    var recordsList = ReservationListModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordsList.loadOwnerData {
            (result) in
            self.updateUIAsync {
                self.recordsList.groupCurrentReservations()
                self.tableView.reloadData()
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if recordsList.ownerCurrentReservations == nil {
            return 0
        }
        return recordsList.ownerCurrentReservations!.keys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recordsModel = recordsList.ownerCurrentReservations!
        let cell = tableView.dequeueReusableCell(withIdentifier: "ownerCurrentReservationsCell", for: indexPath) as! OwnerCurrentReservationsTableViewCell
        let key = Array(recordsModel.keys)[indexPath.row]
        
        cell.titleLabel.text = recordsModel[key]![0].title
        cell.addressLabel.text = recordsModel[key]![0].address
        cell.reservationsCountLabel.text = String(recordsModel[key]!.count) + " Reservations"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recordsModel = recordsList.ownerCurrentReservations!
        let key = Array(recordsModel.keys)[indexPath.row]
        let items = recordsModel[key]
        
        let destination = storyboard?.instantiateViewController(withIdentifier: "currentReservationsDetailView") as! CurrentReservationDetailTableViewController
        destination.postList = items
        navigationController?.pushViewController(destination, animated: true)
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSidebarFromCurrentReservationsSegue" {
            let destination = segue.destination as! UISideMenuNavigationController
            let destinationTable = destination.viewControllers.first as! OwnerSidebarTableViewController
            destinationTable.currentUser = currentUser
        }
    }

}
