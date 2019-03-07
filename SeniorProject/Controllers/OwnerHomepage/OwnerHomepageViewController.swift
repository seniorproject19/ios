//
//  OwnerHomepageViewController.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/2/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class OwnerHomepageViewController: UIViewController {
    
    var currentUser: CurrentUserModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func setup() {
        navigationItem.hidesBackButton = false
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
