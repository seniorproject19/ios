//
//  PostRateViewController.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 3/10/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

class PostRateViewController: UIViewController {
    @IBOutlet weak var RateLabel: UILabel!
    
    @IBOutlet weak var rateSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        RateLabel.text = "$, \(rateSlider.value) per hour"
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
