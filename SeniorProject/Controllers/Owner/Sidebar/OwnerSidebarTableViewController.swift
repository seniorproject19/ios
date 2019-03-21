//
//  OwnerSidebarTableViewController.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/17/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class OwnerSidebarTableViewController: UITableViewController {
    
    var currentUser: CurrentUserModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sideBarProfileCell", for: indexPath) as! SidebarProfileTableViewCell
            cell.nameLabel.text = currentUser!.user?.username
            cell.balanceLabel.text = "Balance: $" + String(currentUser!.user!.balance)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sideBarCell", for: indexPath) as! SidebarTableViewCell
            if indexPath.row == 1 {
                cell.sidebarTextLabel.text = "My Posts"
            } else if indexPath.row == 2 {
                cell.sidebarTextLabel.text = "Current Reservations"
            } else if indexPath.row == 3 {
                cell.sidebarTextLabel.text = "Past Reservations"
            } else {
                cell.sidebarTextLabel.text = "Log out"
            }
            return cell
        }

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let destination = storyboard?.instantiateViewController(withIdentifier: "ownerHomePageView") as! OwnerHomepageViewController
            destination.currentUser = currentUser
            navigationController?.pushViewController(destination, animated: true)
        } else if indexPath.row == 2 {
            let destination = storyboard?.instantiateViewController(withIdentifier: "ownerCurrentReservationsListViewController") as! OwnerCurrentReservationsListTableViewController
            destination.currentUser = currentUser
            navigationController?.pushViewController(destination, animated: true)
        } else if indexPath.row == 3 {
            let destination = storyboard?.instantiateViewController(withIdentifier: "ownerPastReservationsListViewController") as! OwnerPastReservationsListTableViewController
            navigationController?.pushViewController(destination, animated: true)
        } else if indexPath.row == 4 {
            currentUser?.logout {
                let destination = self.storyboard?.instantiateViewController(withIdentifier: "appHomePage") as! FirstPageViewController
                self.navigationController?.pushViewController(destination, animated: true)
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

}
