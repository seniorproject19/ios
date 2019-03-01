//
//  OwnerRegistrationViewController.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/1/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class OwnerRegistrationViewController: UIViewController {
    
    let model = NewUserModel()

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        model.username = usernameTextField.text
        model.email = emailTextField.text
        model.password = passwordTextField.text
        model.confirmPassword = confirmPasswordTextField.text
        model.isOwner = true
        model.register {
            (result) in
            // TODO: register result
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
