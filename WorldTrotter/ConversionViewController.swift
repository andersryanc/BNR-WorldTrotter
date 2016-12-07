//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Ryan Anderson on 12/4/16.
//  Copyright © 2016 mranderson. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!

    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        }
        else {
            return nil
        }
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: value))
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // NOTE: DELETE actually registers as an empty string, NOT a "controlCharacter"
        let isDeleteKey = string.isEmpty
        if isDeleteKey {
            return true
        }
        
        let isDecimalPoint = string.contains(".")
        
        let willHaveMultipleDecimals = (textField.text?.contains("."))! && isDecimalPoint
        if willHaveMultipleDecimals {
            return false
        }

        let isDigit = (string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil)
        if !isDigit && !isDecimalPoint {
            return false
        }
        
        let willStartWithDecimalPoint = (textField.text?.isEmpty)! && isDecimalPoint
        if willStartWithDecimalPoint {
            return false
        }
        
        // NOTE: For handling if you type in something like "0003.13" or "0372.83"
        let textStartsWithZeroAndNoDecimal = (textField.text?.range(of: "^0", options: .regularExpression) != nil) && (textField.text?.range(of: "^0\\.", options: .regularExpression) == nil)
        if isDigit && textStartsWithZeroAndNoDecimal {
            return false
        }
        
        return true
    }
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = value
        }
        else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }

}
