//
//  AddMoneyToWallet.swift
//  ExpenditureTracker
//
//  Created by Raghav Sharma on 08/01/17.
//  Copyright © 2017 Original Thinkers. All rights reserved.
//

import UIKit

class AddMoneyToWallet: UIViewController{
    
    @IBOutlet weak var moneyToAdd: UITextField!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var addMoneyOut: UIButton!
    
    override func viewDidLoad() {
        moneyToAdd.keyboardType = UIKeyboardType.decimalPad
        moneyToAdd.placeholder = "Money to Add"
        moneyToAdd.isEnabled = true
        self.hideKeyboard()
    }
    
    @IBAction func addMoneyAction(_ sender: Any) {
        //Checking if any value is passed
        var moneyToAddSTR = moneyToAdd.text!
        if moneyToAddSTR.characters.count < 1{
            statusLabel.text = "Please add a value"
            statusLabel.textColor = UIColor.red
        }
            //If value then setting limit and saving data
        else{
            BasicFunctionality().walletToAdd(amount: Double(moneyToAdd.text!)!)
            BasicFunctionality().saveData()
            BasicFunctionality().widgetFunctionality()
            statusLabel.textColor = UIColor.black
            statusLabel.text = "You have successfully added ₹\(Wallet.moneyLeftInWallet) to your wallet."
            addMoneyOut.isEnabled = false
            moneyToAdd.isEnabled = false
        }
    }
    @IBAction func exitButtonAction(_ sender: Any) {
        print("\(Wallet.moneyLeftInWallet)")
    }
    
}
