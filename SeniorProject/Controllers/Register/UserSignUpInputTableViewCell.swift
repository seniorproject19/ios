//
//  UserSignUpInputTableViewCell.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/19/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class UserSignUpInputTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var finishEditingHandler: ((String?) -> Void)? = nil

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var inputLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        inputTextField.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        finishEditingHandler!(textField.text)
    }

}
