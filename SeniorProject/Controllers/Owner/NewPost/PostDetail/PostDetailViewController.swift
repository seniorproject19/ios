//
//  PostDetailViewController.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 2/26/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit
import TLPhotoPicker

class PostDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var model: PostModel? = nil
    var photoCollectionView: UICollectionView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addPhotos(_ sender: Any) {
        let pickerViewController = PostDetailMultiplePickerViewController()
        pickerViewController.delegate = self
        pickerViewController.didExceedMaximumNumberOfSelection = { [weak self] (picker) in
            self?.showAlert(withTitle: "Exceed Maximum Number Of Selection", message: "Please select less photo")
        }
        
        var configure = TLPhotosPickerConfigure()
        configure.numberOfColumn = 3
        pickerViewController.configure = configure
        self.present(pickerViewController, animated: true, completion: nil)
    }
/*
    @IBAction func createButtonPressed(_ sender: Any) {
        let utcDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        model?.datePosted = formatter.string(from: utcDate)
        model?.title = titleTextField.text
        model?.description = descriptionTextView.text
        model?.post {
            // TODO: error handling
        }
    }
 */
    /*
    @IBAction func nextButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "showTimeSlotsTableViewSegue", sender: self)
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let utcDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        model?.datePosted = formatter.string(from: utcDate)
        view.endEditing(true)
        model?.post {
            if segue.identifier == "showTimeSlotsTableViewSegue" {
                if let destination = segue.destination as? TimeSlotListTableViewController {
                    destination.model = self.model
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "postInputTableViewCell", for: indexPath) as! PostInputTableViewCell
                cell.label.text = "Title"
                cell.inputTextField.text = model!.title
                cell.inputTextField.autocorrectionType = .no
                cell.finishEditingHandler = updateTitle
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "postInputTableViewCell", for: indexPath) as! PostInputTableViewCell
                cell.label.text = "Description"
                cell.inputTextField.text = model!.description
                cell.inputTextField.autocorrectionType = .no
                cell.finishEditingHandler = updateDescription
                return cell
            }
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "postPhotoCollectionTableViewCell", for: indexPath) as! PostPhotoCollectionTableViewCell
            photoCollectionView = cell.photoCollectionView
            cell.setCollectionViewDataSourceDelegate(self)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "postTableViewCell", for: indexPath) as! PostTableViewCell
            cell.label.text = "Next"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2  {
            self.view.endEditing(true)
            performSegue(withIdentifier: "showTimeSlotsTableViewSegue", sender: self)
        }
    }
    
    func updateTitle(_ title: String?) {
        self.model!.title = title
    }
    
    func updateDescription(_ description: String?) {
        self.model!.description = description
    }
    


}

extension PostDetailViewController: TLPhotosPickerViewControllerDelegate {
    
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        for asset in withTLPHAssets {
            if let model = model {
                model.addImages(image: asset.fullResolutionImage!)
            }
            photoCollectionView!.reloadData()
        }
    }
    
}

extension PostDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if let model = model {
            count = model.countImages()
        }
        if count >= 9 {
            return 9
        }
        return count + 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
            cell.layer.borderColor = UIColor.gray.cgColor
            cell.layer.borderWidth = 1
            return cell
        } else {
            let image = model?.getImage(atIndex: indexPath.row - 1)
            // construct cell to show image
            let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier:  "photoCell", for: indexPath) as! PostDetailSelectorImageCell
            
            // Configure the cell
            photoCell.backgroundColor = UIColor.black
            photoCell.imageView.image = image
            return photoCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
}


