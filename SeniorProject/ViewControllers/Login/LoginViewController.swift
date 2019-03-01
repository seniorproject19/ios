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

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        self.currentUser.login(username: userNameTextField.text!, password: passwordTextField.text!) {
            (result) in
            switch (result) {
            case .success:
                self.updateUIAsync {
                    let destination = self.storyboard?.instantiateViewController(withIdentifier: "userMainMapView") as! MapViewController
                    destination.currentUser = self.currentUser
                    self.navigationController?.pushViewController(destination, animated: true)
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
