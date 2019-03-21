//
//  OwnerPostTableViewController.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/17/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class OwnerPostTableViewController: UITableViewController {
    
    var model: PostModel? = nil
    var cellPageControl: UIPageControl? = nil

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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ownerPostMapViewCell", for: indexPath) as! OwnerPostMapViewTableViewCell
            cell.latitude = model?.latitude
            cell.longitude = model?.longitude
            cell.placeAnnotation()
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ownerPostTitleAddressCell", for: indexPath) as! OwnerPostTitleAddressTableViewCell
            cell.datePostedLabel.text = model?.datePosted
            cell.titleLabel.text = model?.title
            cell.addressLabel.text = model?.address
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ownerPostDescriptionCell", for: indexPath) as! OwnerPostDescriptionTableViewCell
            cell.descriptionContentLabel.text = model?.description
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ownerPostAvailabilityCell", for: indexPath) as! OwnerPostAvailabilityTableViewCell
            cell.availabilityContentLabel.text = model?.availabilityTableModel.description
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ownerPostImageScrollViewCell", for: indexPath) as! OwnerPostImageScrollViewTableViewCell
            let imageViews = loadScrollImageViews()
            setupImageScrollView(scrollView: cell.scrollView, imageViews: imageViews)
            self.cellPageControl = cell.pageControl
            cell.pageControl.numberOfPages = model!.imagePaths!.count
            cell.pageControl.currentPage = 0
            return cell
        } else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ownerPostEditPostCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ownerPostRemovePostCell", for: indexPath)
            return cell
        }
    }
    
    func loadScrollImageViews() -> [PostImageScrollViewImageView] {
        var imageViews = [PostImageScrollViewImageView]()
        for path in model!.imagePaths! {
            let view = PostImageScrollViewImageView()
            view.imageView.image = UIImage(color: .lightGray)
            model?.getImageFromServer(at: path) {
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 5) {
            let destination = self.storyboard?.instantiateViewController(withIdentifier: "editPostDetailView") as! EditPostDetailViewController
            destination.model = model
            self.navigationController?.pushViewController(destination, animated: true)
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
