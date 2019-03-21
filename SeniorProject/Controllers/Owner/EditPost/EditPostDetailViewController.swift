//
//  EditPostDetailViewController.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/18/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit
import TLPhotoPicker

class EditPostDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var model: PostModel? = nil
    var photoCollectionView: UICollectionView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        view.endEditing(true)
        if segue.identifier == "showEditTimeSlotsSegue" {
            if let destination = segue.destination as? EditTimeSlotListTableViewController {
                destination.model = self.model
            }
        }
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
            return 3
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "editPostTableViewCell", for: indexPath) as! EditPostTableViewCell
                let address = model!.address ?? ""
                cell.buttonLabel.text = "Address\n \(address)"
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "editPostInputTableViewCell", for: indexPath) as! EditPostInputTableViewCell
                cell.inputLabel.text = "Title"
                cell.inputTextField.text = model!.title
                cell.inputTextField.autocorrectionType = .no
                cell.finishEditingHandler = updateTitle
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "editPostInputTableViewCell", for: indexPath) as! EditPostInputTableViewCell
                cell.inputLabel.text = "Description"
                cell.inputTextField.text = model!.description
                cell.inputTextField.autocorrectionType = .no
                cell.finishEditingHandler = updateDescription
                return cell
            }
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "editPostPhotoCollectionTableViewCell", for: indexPath) as! EditPostPhotoCollectionTableViewCell
            photoCollectionView = cell.photoCollectionView
            cell.setCollectionViewDataSourceDelegate(self)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "editPostTableViewCell", for: indexPath) as! EditPostTableViewCell
            cell.buttonLabel.text = "Next"
            return cell
        }
    }
    
    func reloadCollectionViewData() {
        photoCollectionView?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2  {
            self.view.endEditing(true)
            model?.update {
                self.updateUIAsync {
                    self.performSegue(withIdentifier: "showEditTimeSlotsSegue", sender: self)
                }
            }
        }
    }
    
    func updateTitle(_ title: String?) {
        self.model!.title = title
    }
    
    func updateDescription(_ description: String?) {
        self.model!.description = description
    }
    

}

extension EditPostDetailViewController: TLPhotosPickerViewControllerDelegate {
    
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        for asset in withTLPHAssets {
            if let model = model {
                model.addImages(image: asset.fullResolutionImage!)
            }
            photoCollectionView!.reloadData()
        }
    }
    
}

extension EditPostDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
