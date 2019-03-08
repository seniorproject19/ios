//
//  PostDetailViewController.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 2/26/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit
import TLPhotoPicker

class PostDetailViewController: UIViewController {

    var model: NewPostModel? = nil
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PostDetailViewController: TLPhotosPickerViewControllerDelegate {
    
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        for asset in withTLPHAssets {
            if let model = model {
                model.addImages(image: asset.fullResolutionImage!)
            }
            photoCollectionView.reloadData()
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
            cell.backgroundColor = UIColor.blue
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
    
}


