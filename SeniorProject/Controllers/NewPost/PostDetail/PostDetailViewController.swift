//
//  PostDetailViewController.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 2/26/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit


class PostDetailViewController: UIViewController {

    var userSelectedPhotos: [UIImage] = [UIImage]()
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    @IBAction func addPhotos(_ sender: Any) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType =  UIImagePickerController.SourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
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

extension PostDetailViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image_data = info["UIImagePickerControllerOriginalImage"] as? UIImage
        let imageData:Data = image_data!.pngData()!
        let imageStr = imageData.base64EncodedString()
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PostDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if userSelectedPhotos.count >= 9 {
            return 9
        }
        return userSelectedPhotos.count + 1
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
            let image = userSelectedPhotos[indexPath.row - 1]
            // construct cell to show image
            let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier:  "photoCell", for: indexPath) as! PostDetailSelectorImageCell
            
            // Configure the cell
            photoCell.backgroundColor = UIColor.black
            photoCell.imageView.image = image
            return photoCell
        }
    }
    
}


