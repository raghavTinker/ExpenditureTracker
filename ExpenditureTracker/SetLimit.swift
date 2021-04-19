//
//  SetLimit.swift
//  ExpenditureTracker
//
//  Created by Raghav Sharma on 07/01/17.
//  Copyright © 2017 Original Thinkers. All rights reserved.
//

import UIKit

class SetLimit: UIViewController {
    
    //Limit text field
    @IBOutlet weak var limit: UITextField!
    
    //Exit button outlet
    @IBOutlet weak var exitOutlet: UIButton!
    
    //Status label outlet
    @IBOutlet weak var statusLabel: UILabel!
    
    //Set button outlet
    @IBOutlet weak var setOutlet: UIButton!

    
    //Override function
    override func viewDidLoad() {
        //Checking Date
        
        limit.keyboardType = UIKeyboardType.decimalPad
        limit.placeholder = "Enter spending limit"
        limit.isEnabled = true
        
        //Hiding keyboard if the background is pressed
        self.hideKeyboard()
    }
    
    //Set button action
    @IBAction func setButton(_ sender: Any) {
        var newLimit = limit.text!
        
        //Checking if any value is passed
        if newLimit.characters.count < 1{
            statusLabel.text = "Please add a value"
            statusLabel.textColor = UIColor.red
        }
            //If value then setting limit and saving data
        else{
            setOutlet.isEnabled = false
            setOutlet.backgroundColor = UIColor.white
            exitOutlet.isEnabled = true
            Wallet.moneyLimit = Double(newLimit)!
            statusLabel.textColor = UIColor.black
            statusLabel.text = "The limit of wallet has been changed to ₹\(Wallet.moneyLimit)."
            BasicFunctionality().saveData()
            BasicFunctionality().widgetFunctionality()
            limit.isEnabled = false
        }
    }
    
    @IBAction func exitButtonAction(_ sender: Any) {
        print("Limit Set")
    }
}
