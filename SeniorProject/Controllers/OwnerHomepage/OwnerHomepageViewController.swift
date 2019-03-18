//
//  OwnerHomepageViewController.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/17/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit
import SideMenu

class OwnerHomepageViewController: UITableViewController {
    
    var postList = PostListModel()
    var currentUser: CurrentUserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SideMenuManager.default.menuFadeStatusBar = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 45
        
        if currentUser == nil {
            currentUser = CurrentUserModel()
            currentUser?.loadUser {
                (succeeded) in
                if !succeeded {
                    self.updateUIAsync {
                        let destination = self.storyboard?.instantiateViewController(withIdentifier: "appHomePage") as! FirstPageViewController
                        self.navigationController?.pushViewController(destination, animated: true)
                    }
                } else {
                    self.setup()
                }
            }
        } else {
            setup()
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToOwnerHomepageViewController(segue: UIStoryboardSegue) {
        self.setup()
    }
    
    func setup() {
        postList = PostListModel()
        postList.loadData {
            (result) in
            if result == .success {
                self.updateUIAsync {
                    self.tableView.reloadData()
                }
            } else {
                self.updateUIAsync {
                    let destination = self.storyboard?.instantiateViewController(withIdentifier: "appHomePage") as! FirstPageViewController
                    self.navigationController?.pushViewController(destination, animated: true)
                }
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
        return postList.count()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postListEntryCell", for: indexPath) as! PostListEntryTableViewCell
        let postModel = postList.get(indexPath.row)
        
        cell.titleLabel.text = postModel.title
        cell.addressLabel.text = postModel.address

        return cell
    }
  
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            self.postList.entries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            print(self.postList.entries)
        }
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            // share item at indexPath
            print("I want to edit: \(self.postList.entries[indexPath.row])")
            
            let postId = self.postList.get(indexPath.row).pid
            let postModel = PostModel()
            
            postModel.pid = postId
            postModel.loadData {
                (result) in
                if result == .success {
                    self.updateUIAsync {
                        let destination = self.storyboard?.instantiateViewController(withIdentifier: "EditPostDetailView") as! EditPostDetailViewController
                        destination.model = postModel
                        self.navigationController?.pushViewController(destination, animated: true)
                    }
                } else {
                    self.showAlert(withTitle: "Error", message: "Unable to Load Post Info")
                }
            }
        }
        
        edit.backgroundColor = UIColor.lightGray
        return [delete, edit]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postId = postList.get(indexPath.row).pid
        let postModel = PostModel()
        
        postModel.pid = postId
        postModel.loadData {
            (result) in
            if result == .success {
                self.updateUIAsync {
                    let destination = self.storyboard?.instantiateViewController(withIdentifier: "ownerPostTableView") as! OwnerPostTableViewController
                    destination.model = postModel
                    self.navigationController?.pushViewController(destination, animated: true)
                }
            } else {
                self.showAlert(withTitle: "Error", message: "Unable to Load Post Info")
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
