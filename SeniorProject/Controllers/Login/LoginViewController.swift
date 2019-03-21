//
//  LoginViewController.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 2/14/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    let currentUser: CurrentUserModel = CurrentUserModel()
    
    var defaultUsername: String? = nil
    
    var username: String? = nil
    var password: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        

        // Do any additional setup after loading the view.
    }
 /*
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
    }*/
    
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
        } else if section == 1 {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "loginInputCell", for: indexPath) as! LoginInputTableViewCell
                cell.inputLabel.text = "Username"
                if defaultUsername != nil {
                    cell.inputTextField.text = defaultUsername
                    self.username = defaultUsername
                }
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.inputTextField.autocorrectionType = .no
                cell.finishEditingHandler = updateUsername
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "loginInputCell", for: indexPath) as! LoginInputTableViewCell
                cell.inputLabel.text = "Password"
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.inputTextField.isSecureTextEntry = true
                cell.finishEditingHandler = updatePassword
                return cell
            }
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loginCell", for: indexPath) as! LoginTableViewCell
            cell.signUpLabel.text = "Login"
            return cell
        } else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "loginSignUpTableViewCell", for: indexPath) as! LoginSignUpTableViewCell
                cell.label.text = "New User? Sign Up"
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "loginSignUpTableViewCell", for: indexPath) as! LoginSignUpTableViewCell
                cell.label.text = "New Parking Space Owner? Sign Up"
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            self.view.endEditing(true)
            self.currentUser.login(username: username, password: password) {
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
                case .emptyFields:
                    self.updateUIAsync {
                        self.showAlert(withTitle: "Username and Password cannot be Empty", message: "Please enter username or password")
                    }
                }
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {//
                performSegue(withIdentifier: "loginSegueToNewUserSignUp", sender: self)
            } else {
                performSegue(withIdentifier: "loginSegueToNewOwnerSignUp", sender: self)
            }
        }
    }
    
    func updateUsername(_ username: String?) {
        self.username = username
    }
    
    
    func updatePassword(_ password: String?) {
        self.password = password
    }

}
