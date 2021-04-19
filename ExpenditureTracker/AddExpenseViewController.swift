//
//  AddExpenseViewController.swift
//  ExpenditureTracker
//
//  Created by Raghav Sharma on 04/01/17.
//  Copyright © 2017 Original Thinkers. All rights reserved.
//

import UIKit
import LocalAuthentication

class AddExpenseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIViewControllerTransitioningDelegate{
    var moneyLeft: Double = 0.0
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    //Outlets
    @IBOutlet weak var moneySpent: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var wallet: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var digaHoleOutlet: UIButton!
    @IBOutlet weak var addMoreOutlet: UIButton!
    @IBOutlet weak var labelOptions: UIPickerView!
    @IBOutlet weak var moneyLimitLeft: UILabel!
    
    //Transaction Labels
    let transactionLabels: [String] = ["Miscellaneous", "Vegetables", "Grocery", "Shopping", "Entertainment", "Electronics", "Bills", "Travel"]

    var transactionLabel: String = ""
    
    //Money spending
    var money = 0.0
    override func viewDidLoad() {
        
        super.viewDidLoad()
        BasicFunctionality().retrieveData()
        BasicFunctionality().checkDate()
        moneyLimitLeft.text = "\(Wallet.moneyLimit - Wallet.moneySpent)"
        moneySpent.keyboardType = UIKeyboardType.decimalPad
        wallet.text = "\(Wallet.moneyLeftInWallet)"
        print(Wallet.moneyLeftInWallet)
        
        //Loading Indicator
        loadingIndicator.hidesWhenStopped = true
        
        //Add more outlet
        addMoreOutlet.isEnabled = false
        
        
        //Text field enabled or not
        moneySpent.isEnabled = true
        
        //Providing quick exit to the user if no money in the wallet
        if Wallet.moneyLeftInWallet == 0{
            statusLabel.text = "You have no money in you wallet."
            exitButton.isEnabled = true
            digaHoleOutlet.isEnabled = false
            addMoreOutlet.isEnabled = false
        }
        
        //Hiding the keyboard
        self.hideKeyboard()
    }
    
    
    @IBAction func exitButtonAction(_ sender: Any) {
        print("Transaction Exit")
    }
    
    @IBAction func digaHoleButton(_ sender: Any) {
        var str = String(describing: moneySpent.text!)
        //checking if any valaue is passed
        if str.characters.count < 1{
            statusLabel.text = "Please enter the amount spent"
            statusLabel.textColor = UIColor.red
        }
        
        //If valid text given
        else{
            //------------------------------------------
            
            //---Checking if there is any money in the wallet-----
            
            //Save in money variable
            money = Double(self.moneySpent.text!)!
            
            
            //If not enough money
            if Wallet.moneyLeftInWallet < Double(moneySpent.text!)!{
               statusLabel.text = "You do not have enough money in the wallet."
                //If no money readying app exit
                statusLabel.textColor = UIColor.red
                exitButton.isEnabled = true
                digaHoleOutlet.isEnabled = false
            }
            //If enough money
            else{
                if Wallet.moneySpent + money > Wallet.moneyLimit{
                    statusLabel.text = "You are exceeding you money spending limit."
                    statusLabel.textColor = UIColor.red
                    exitButton.isEnabled = true
                }
                else{
                    //Touch ID
                    let isTouchID = BasicFunctionality().touchIDExists()
                    //IF Device with touch ID enrolled and enabled
                    if isTouchID{
                        statusLabel.text = ""
                        statusLabel.textColor = UIColor.black
                        
                        //Bringing up touch id pop up
                        let context: LAContext = LAContext()
                        
                        loadingIndicator.startAnimating()
                        loadingIndicator.color = UIColor.black
                        
                        context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authorize Payment", reply: {(wasSuccesful: Bool, error) in
                            if wasSuccesful{
                                OperationQueue.main.addOperation {
                                    self.exitButton.isEnabled = false
                                    self.addMoreOutlet.isEnabled = false
                                    self.spendMoney()
                                }
                            }
                            else{
                                OperationQueue.main.addOperation {
                                    self.loadingIndicator.stopAnimating()
                                    self.statusLabel.text = "Authorization Failed"
                                    self.statusLabel.textColor = UIColor.red
                                }
                            }})
                    }
                    else{
                        print("No touch id")
                        spendMoney()
                    }
                }
                
            }
        }
    }
    
    
    func spendMoney(){
        loadingIndicator.stopAnimating()
        moneyLeft = BasicFunctionality().reduceWalletValue(by: Double(moneySpent.text!)!)
        statusLabel.text = "Transaction Successfull"
        statusLabel.textColor = UIColor.brown
        wallet.text = "\(Wallet.moneyLeftInWallet)"
        Wallet.moneySpent = Wallet.moneySpent + money
        moneyLimitLeft.text = "\(Wallet.moneyLimit - Wallet.moneySpent)"
        
        //readying app exit
        addMoreOutlet.isEnabled = true
        digaHoleOutlet.isEnabled = false
        exitButton.isEnabled = true
        
        //Label Check
        
        if transactionLabel == ""{
            mis(moneySpent: money)
        }
        else{
            switch transactionLabel{
            case transactionLabels[0]: mis(moneySpent: money)
            case transactionLabels[1]: veg(moneySpent: money)
            case transactionLabels[2]: gro(moneySpent: money)
            case transactionLabels[3]: shop(moneySpent: money)
            case transactionLabels[4]: entertain(moneySpent: money)
            case transactionLabels[5]: elec(moneySpent: money)
            case transactionLabels[6]: bills(moneySpent: money)
            case transactionLabels[7]: travel(moneySpent: money)
            default: mis(moneySpent: money)
            }
        }
        
        //Permanently saving data
        BasicFunctionality().saveData()
        transactionLabel = ""
        
        //Readying app exit
        exitButton.isEnabled = true
        addMoreOutlet.isEnabled = true
        BasicFunctionality().widgetFunctionality()
        moneySpent.isEnabled = false
    }
    
    
    @IBAction func addMoreAction(_ sender: Any) {
        BasicFunctionality().checkDate()
        digaHoleOutlet.isEnabled = true
        moneySpent.text = ""
        wallet.text = "\(Wallet.moneyLeftInWallet)"
        if Wallet.moneyLeftInWallet == 0{
            digaHoleOutlet.isEnabled = false
            exitButton.isEnabled = true
            moneySpent.text = ""
            statusLabel.text = "You have no money in you wallet."
            moneySpent.isEnabled = false
        }
        else{
            addMoreOutlet.isEnabled = false
            moneyLimitLeft.text = "\(Wallet.moneyLimit - Wallet.moneySpent)"
            moneySpent.isEnabled = true
            exitButton.isEnabled = true
        }
    }
    
    //Picker Functions
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return transactionLabels[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return transactionLabels.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        transactionLabel = String(transactionLabels[row])
    }
    
   
    
    //Adding money spent on the categories
    func mis(moneySpent: Double){
        Wallet.miscellaneous = moneySpent + Wallet.miscellaneous
        print("Here")
    }
    func veg(moneySpent: Double){
        Wallet.vegetables = moneySpent + Wallet.vegetables
    }
    func gro(moneySpent: Double){
        Wallet.grocery = moneySpent + Wallet.grocery
    }
    func shop(moneySpent: Double){
        Wallet.shopping = moneySpent + Wallet.shopping
    }
    func entertain(moneySpent: Double){
        Wallet.entertainment = moneySpent + Wallet.entertainment
    }
    func elec(moneySpent: Double){
        Wallet.electronics = moneySpent + Wallet.electronics
    }
    func bills(moneySpent: Double){
        Wallet.bills = moneySpent + Wallet.bills
    }
    func travel(moneySpent: Double){
        Wallet.travel = moneySpent + Wallet.travel
    }
    
    
}
