//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Ryan Anderson on 12/4/16.
//  Copyright © 2016 mranderson. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController {
    
    @IBOutlet weak var celsiusLabel: UILabel!
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            celsiusLabel.text = text
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
}