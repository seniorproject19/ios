//
//  ReservationDetailTableViewController.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/20/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit
import MapKit

class ReservationDetailTableViewController: UITableViewController {

    var pastReservationModel: PastReservationModel? = nil
    var reservationModel: ReservationDetailModel? = nil
    var currentUser: CurrentUserModel? = nil
    var cellPageControl: UIPageControl? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "unwindToUserReservationsSegue", sender: self)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if pastReservationModel != nil {
            return 3
        }
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userPostMapViewCell", for: indexPath) as! OwnerPostMapViewTableViewCell
            cell.latitude = reservationModel?.latitude
            cell.longitude = reservationModel?.longitude
            cell.placeAnnotation()
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userPostTitleAddressCell", for: indexPath) as! ReservationDetailTitleAddressTableViewCell
            if pastReservationModel != nil {
                cell.reservationStatus.text = "Completed"
                cell.reservationStatus.textColor = UIColor.orange
                cell.titleLabel.text = pastReservationModel!.title
                cell.addressLabel.text = pastReservationModel!.address
                cell.plateLabel.text = pastReservationModel!.plate
                cell.timeLabel.text = pastReservationModel!.requestedTimeDescription
            } else {
                cell.titleLabel.text = reservationModel!.title
                cell.addressLabel.text = reservationModel!.address
                cell.plateLabel.text = reservationModel!.plate
                cell.timeLabel.text = reservationModel!.requestedTimeDescription
            }
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userPostDescriptionCell", for: indexPath) as! OwnerPostDescriptionTableViewCell
            if pastReservationModel != nil {
                cell.descriptionContentLabel.text = pastReservationModel?.description
            } else {
                cell.descriptionContentLabel.text = reservationModel?.postModel?.description
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userPostImageScrollViewCell", for: indexPath) as! OwnerPostImageScrollViewTableViewCell
            let imageViews = loadScrollImageViews()
            setupImageScrollView(scrollView: cell.scrollView, imageViews: imageViews)
            self.cellPageControl = cell.pageControl
            cell.pageControl.numberOfPages = reservationModel!.postModel!.imagePaths!.count
            cell.pageControl.currentPage = 0
            return cell
        }
    }
    
    func loadScrollImageViews() -> [PostImageScrollViewImageView] {
        var imageViews = [PostImageScrollViewImageView]()
        for path in reservationModel!.postModel!.imagePaths! {
            let view = PostImageScrollViewImageView()
            view.imageView.image = UIImage(color: .lightGray)
            reservationModel!.postModel!.getImageFromServer(at: path) {
                (image) in
                self.updateUIAsync {
                    view.imageView.image = image
                }
            }
            imageViews.append(view)
        }
        return imageViews
    }
    
    func setupImageScrollView(scrollView: UIScrollView, imageViews: [PostImageScrollViewImageView]) {
        let contentWidth = UIScreen.main.bounds.width - 32
        
        scrollView.contentSize = CGSize(width: contentWidth * CGFloat(imageViews.count), height: 0)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        for i in 0 ..< imageViews.count {
            imageViews[i].frame = CGRect(x: contentWidth * CGFloat(i), y: 0, width: contentWidth, height: scrollView.frame.height)
            imageViews[i].imageView.frame = CGRect(x: 0, y: 0, width: contentWidth, height: imageViews[i].frame.height)
            scrollView.addSubview(imageViews[i])
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView != self.tableView {
            let contentWidth = UIScreen.main.bounds.width - 32
            let pageIndex = round(scrollView.contentOffset.x / contentWidth)
            if cellPageControl != nil {
                cellPageControl!.currentPage = Int(pageIndex)
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
