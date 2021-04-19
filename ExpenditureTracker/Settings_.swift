//
//  Settings.swift
//  ExpenditureTracker
//
//  Created by Raghav Sharma on 07/01/17.
//  Copyright © 2017 Original Thinkers. All rights reserved.
//

import UIKit

class Settings: UIViewController {
    
    //Limit text field
    @IBOutlet weak var limit: UITextField!
    
    //Exit button outlet
    @IBOutlet weak var exitOutlet: UIButton!
    
    //Status label outlet
    @IBOutlet weak var statusLabel: UILabel!
    
    //Set button outlet
    @IBOutlet weak var setOutlet: UIButton!
    
    @IBOutlet weak var resetTOutlet: UIButton!
    
    //Override function
    override func viewDidLoad() {
        //Checking Date
        
        limit.keyboardType = UIKeyboardType.decimalPad
        if Wallet.moneySpent == 0{
            resetTOutlet.backgroundColor = UIColor.white
            resetTOutlet.isEnabled = false
        }
        else{
            resetTOutlet.isEnabled = true
            exitOutlet.isEnabled = true
            setOutlet.isEnabled = false
            statusLabel.text = "If you want to set the limit then you will have to reset your transaction history. Otherwise wait for the next month to arrive"
            setOutlet.backgroundColor = UIColor.white
            
        }
        
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
        }
    }
    
    @IBAction func resetTAction(_ sender: Any) {
        BasicFunctionality().resetData()
        resetTOutlet.isEnabled = false
        setOutlet.isEnabled = true
    }
    
    
}
