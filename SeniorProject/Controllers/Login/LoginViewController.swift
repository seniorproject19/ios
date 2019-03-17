//
//  LoginViewController.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 2/14/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let currentUser: CurrentUserModel = CurrentUserModel()
    
    var defaultUsername: String? = nil

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaultUsername != nil {
            usernameTextField.text = defaultUsername
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        self.currentUser.login(username: usernameTextField.text!, password: passwordTextField.text!) {
            (result) in
            switch (result) {
            case .success:
                self.updateUIAsync {
                    if self.currentUser.user!.isOwner {
                        let destination = self.storyboard?.instantiateViewController(withIdentifier: "ownerHomePageView") as! OwnerHomepageViewController
                        destination.currentUser = self.currentUser
                        self.navigationController?.pushViewController(destination, animated: true)
                    } else {
                        let destination = self.storyboard?.instantiateViewController(withIdentifier: "userMainNavigationController") as! UINavigationController
                        let selectDayDestination = destination.viewControllers.first as! UserSelectTimeViewController
                        selectDayDestination.currentUser = self.currentUser
                        self.navigationController?.pushViewController(selectDayDestination, animated: true)
                    }
                }
            case .wrongUsername:
                self.updateUIAsync {
                    self.showAlert(withTitle: "Username not found", message: "Please double check your username")
                }
            case .wrongPassword:
                self.updateUIAsync {
                    self.showAlert(withTitle: "Incorrect Password", message: "Please double check your password")
                }
            case .serverError:
                self.updateUIAsync {
                    self.showAlert(withTitle: "We've encountered some issues", message: "Please try again later")
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

}
