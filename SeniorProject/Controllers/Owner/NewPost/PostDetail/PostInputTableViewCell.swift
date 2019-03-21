//
//  PostInputTableViewCell.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/20/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class PostInputTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    var finishEditingHandler: ((String?) -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        inputTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        finishEditingHandler!(textField.text)
    }

}
