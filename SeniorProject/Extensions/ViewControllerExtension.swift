//
//  BaseViewController.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 2/14/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var currentDate: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            return dateFormatter.string(from: Date())
        }
    }
    
    func updateUIAsync(withFunction function: @escaping () -> Void) {
        DispatchQueue.main.async {
            function()
        }
    }
    
    func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getNextDate(offset: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let currentDate = Date()
        let nextDate = Calendar.current.date(byAdding: .day, value: offset, to: currentDate)
        let nextDateString = dateFormatter.string(from: nextDate!)
        return nextDateString
    }
    
}
