//
//  OwnerRegistrationViewController.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/1/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class OwnerRegistrationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    let model = UserRegisterModel()

  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   // @IBAction func signUpButtonClicked(_ sender: Any) {
        /*
        model.username = usernameTextField.text
        model.email = emailTextField.text
        model.password = passwordTextField.text
        model.confirmPassword = confirmPasswordTextField.text
        model.isOwner = true
        model.register {
            (result) in
            // TODO: register result
            switch result {
            case .success:
                self.updateUIAsync {
                    let destination = self.storyboard?.instantiateViewController(withIdentifier: "loginView") as! LoginViewController
                    destination.defaultUsername = self.model.username
                    self.navigationController?.pushViewController(destination, animated: false)
                }
            case .serverError:
                self.updateUIAsync {
                    self.showAlert(withTitle: "Something went wrong", message: "Please try again later")
                }
            case .illegalInput(let msg):
                self.updateUIAsync {
                    self.showAlert(withTitle: "Please double check your input", message: msg)
                }
            }
        }*/
   // }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ownerSignUpInputCell", for: indexPath) as! OwnerSignUpInputTableViewCell
                cell.inputLabel.text = "Name"
                cell.inputTextField.autocorrectionType = .no
                cell.finishEditingHandler = updateUsername
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ownerSignUpInputCell", for: indexPath) as! OwnerSignUpInputTableViewCell
                cell.inputLabel.text = "Email"
                cell.inputTextField.autocorrectionType = .no
                cell.finishEditingHandler = updateEmail
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ownerSignUpInputCell", for: indexPath) as! OwnerSignUpInputTableViewCell
                cell.inputLabel.text = "Password"
                cell.inputTextField.isSecureTextEntry = true
                cell.finishEditingHandler = updatePassword
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ownerSignUpInputCell", for: indexPath) as! OwnerSignUpInputTableViewCell
                cell.inputLabel.text = "Re-enter Password"
                cell.inputTextField.isSecureTextEntry = true
                cell.finishEditingHandler = updateConfirmPassword
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ownerSignUpCell", for: indexPath) as! OwnerSignUpTableViewCell
            cell.signUpLabel.text = "Sign Up"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            self.view.endEditing(true)
            model.isOwner = true
            model.register {
                (result) in
                // TODO: register result
                switch result {
                case .success:
                    self.updateUIAsync {
                        let destination = self.storyboard?.instantiateViewController(withIdentifier: "appHomePage") as! LoginViewController
                        destination.defaultUsername = self.model.username
                        self.navigationController?.pushViewController(destination, animated: false)
                    }
                case .serverError:
                    self.updateUIAsync {
                        self.showAlert(withTitle: "Something went wrong", message: "Please try again later")
                    }
                case .illegalInput(let msg):
                    self.updateUIAsync {
                        self.showAlert(withTitle: "Please double check your input", message: msg)
                    }
                }
            }
        }
    }
    
    func updateUsername(_ username: String?) {
        self.model.username = username
    }
    
    func updateEmail(_ email: String?) {
        self.model.email = email
    }
    
    func updatePassword(_ password: String?) {
        self.model.password = password
    }
    
    func updateConfirmPassword(_ confirmPassword: String?) {
        self.model.confirmPassword = confirmPassword
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
