//
//  BasicFunctionality.swift
//  ExpenditureTracker
//
//  Created by Raghav Sharma on 04/01/17.
//  Copyright © 2017 Original Thinkers. All rights reserved.
//
import UIKit
import LocalAuthentication



//This is the BasicFunctionality class where all the basic functionality resides her
class BasicFunctionality{
    
    //var audioPlayer = Wallet.audioPlayer
    
    let dateObj = DateExtractor()
    
    func reduceWalletValue(by decrement: Double) -> Double{
        Wallet.moneyLeftInWallet = Wallet.moneyLeftInWallet - decrement
        return Wallet.moneyLeftInWallet
    }
    
    func getMoneyLeftInWallet() -> Double{
        return Wallet.moneyLeftInWallet
    }
    
    func getMoneySpent() -> Double{
        return Wallet.moneyLimit - Wallet.moneyLeftInWallet
    }
    
    func saveData(){
        UserDefaults.standard.setValue(Wallet.moneyLeftInWallet, forKey: "wallet")
        UserDefaults.standard.setValue(Wallet.isReset, forKey: "resetBool")
        UserDefaults.standard.setValue(Wallet.isReset01, forKey: "resetBool01")
        
        UserDefaults.standard.setValue(Wallet.vegetables, forKey: "vegetables")
        UserDefaults.standard.setValue(Wallet.bills, forKey: "bills")
        UserDefaults.standard.setValue(Wallet.travel, forKey: "travel")
        UserDefaults.standard.setValue(Wallet.miscellaneous, forKey: "miscellaneous")
        UserDefaults.standard.setValue(Wallet.grocery, forKey: "grocery")
        UserDefaults.standard.setValue(Wallet.electronics, forKey: "electronics")
        UserDefaults.standard.setValue(Wallet.entertainment, forKey: "entertainment")
        UserDefaults.standard.setValue(Wallet.shopping, forKey: "shopping")
        UserDefaults.standard.setValue(Wallet.moneyLimit, forKey: "limit")
        
        UserDefaults.standard.setValue(Wallet.moneySpent, forKey: "moneySpent")
        
        UserDefaults.standard.setValue(Wallet.isMusicNeeded, forKey: "musicNeed")
        UserDefaults.standard.setValue(Wallet.isMusicPlaying, forKey: "isMusicPlaying")
    }
    
    
    func retrieveData(){
        if let userWallet = UserDefaults.standard.object(forKey: "wallet") as? Double{
            Wallet.moneyLeftInWallet = userWallet
        }
        else{
            print("Error")
        }
        
        if let limit = UserDefaults.standard.object(forKey: "limit") as? Double{
            Wallet.moneyLimit = limit
        }
        
        if let resetBool = UserDefaults.standard.object(forKey: "resetBool") as? Bool{
            Wallet.isReset = resetBool
        }
        else{
            print("Error")
        }
        
        if let resetBool01 = UserDefaults.standard.object(forKey: "resetBool01") as? Bool{
            Wallet.isReset01 = resetBool01
        }
        else{
            print("Error")
        }
        
        if let moneySpent = UserDefaults.standard.object(forKey: "moneySpent") as? Double{
            Wallet.moneySpent = moneySpent
        }
        else{
            print("Error")
        }
        
        if let isMusicNeeded = UserDefaults.standard.object(forKey: "musicNeed") as? Bool{
            Wallet.isMusicNeeded = isMusicNeeded
            print("Is music NEEDED:\(Wallet.isMusicNeeded)")
        }
        else{
            print("Error")
        }
        
        if let isMusicPlaying = UserDefaults.standard.object(forKey: "isMusicPlaying") as? Bool{
            Wallet.isMusicPlaying = isMusicPlaying
            
        }
        else{
            print("Error")
        }
        
        //Retrieving data for transaction labels
        if let veg = UserDefaults.standard.object(forKey: "vegetables") as? Double, let grocery = UserDefaults.standard.object(forKey: "grocery") as? Double, let shopping = UserDefaults.standard.object(forKey: "shopping") as? Double, let entertainment = UserDefaults.standard.object(forKey: "entertainment") as? Double, let electronics = UserDefaults.standard.object(forKey: "electronics") as? Double, let bills = UserDefaults.standard.object(forKey: "bills") as? Double, let travel = UserDefaults.standard.object(forKey: "travel") as? Double, let mis = UserDefaults.standard.object(forKey: "miscellaneous") as? Double{
            Wallet.vegetables = veg
            Wallet.grocery = grocery
            Wallet.shopping = shopping
            Wallet.entertainment = entertainment
            Wallet.electronics = electronics
            Wallet.bills = bills
            Wallet.travel = travel
            Wallet.miscellaneous = mis
            
            
        }
    }
    
    func resetData(){
        Wallet.vegetables = 0.0
        Wallet.grocery = 0.0
        Wallet.shopping = 0.0
        Wallet.entertainment = 0.0
        Wallet.electronics = 0.0
        Wallet.bills = 0.0
        Wallet.travel = 0.0
        Wallet.miscellaneous = 0.0
        Wallet.moneyLeftInWallet = Wallet.moneyLeftInWallet
        Wallet.moneyLimit = Wallet.moneyLimit
        Wallet.moneySpent = 0.0
        Wallet.isMusicNeeded = true
        saveData()
    }
    
    func checkDate(){
        let currentDate: [String] = dateObj.getExactDate()
        print(currentDate)
        if currentDate[0] == "01"{
            print(currentDate[1])
            if Wallet.isReset01 == true{
            }
            else{
                BasicFunctionality().resetData()
                Wallet.isReset = true
                Wallet.isReset01 = true
            }
        }
        else{
            if Wallet.isReset == false && Wallet.isReset01 == false{
                Wallet.isReset = true
                Wallet.isReset01 = false
                resetData()
                
            }
            else{
                Wallet.isReset = true
                Wallet.isReset01 = false
                saveData()
            }
        }
    }
    
    func walletToAdd(amount: Double){
        Wallet.moneyLeftInWallet = Wallet.moneyLeftInWallet + amount
    }
    
    func resetWallet(){
        Wallet.moneyLeftInWallet = 0.0
        saveData()
    }
    func resetSpendingLimit(){
        Wallet.moneyLimit = 0.0
        saveData()
    }
    
    func factoryReset(){
        Wallet.vegetables = 0.0
        Wallet.grocery = 0.0
        Wallet.shopping = 0.0
        Wallet.entertainment = 0.0
        Wallet.electronics = 0.0
        Wallet.bills = 0.0
        Wallet.travel = 0.0
        Wallet.miscellaneous = 0.0
        Wallet.moneyLeftInWallet = 0.0
        Wallet.moneyLimit = 0.0
        Wallet.moneySpent = 0.0
        saveData()
    }
    
    func touchIDExists() -> Bool{
        var boolean = false
        let context: LAContext = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil){
            boolean = true
        }
        else{
            boolean = false
        }
        return boolean
    
    }
    
    //Getting the last date of the month
    func lastDayOfMonth2() -> Date
    {
        let calendar = Calendar.current
        let now = Date()
        var components = calendar.dateComponents([.year, .month, .day], from: now)
        let range = calendar.range(of: .day, in: .month, for: now)!
        components.day = range.upperBound - 1
        return calendar.date(from: components)!
    }
    
    func sendDate() -> Int{
        print(lastDayOfMonth2())
        let lastDate = String(describing: lastDayOfMonth2())
        let subString = lastDate.components(separatedBy: "-")
        let subsubString = subString[2].components(separatedBy: " ")
        print(subsubString)
        let date = Int(subsubString[0])
        return date!
    }
    
    //Widget Variables
    func widgetFunctionality(){
        BasicFunctionality().retrieveData()
        UserDefaults.init(suiteName: "group.Raghav.ExpenditureTracker")?.set("\(Wallet.moneyLeftInWallet)", forKey: "moneyLeft")
        UserDefaults.init(suiteName: "group.Raghav.ExpenditureTracker")?.set("\(Wallet.moneyLimit - Wallet.moneySpent)", forKey: "limitLeft")
    }
}

//For hiding keyboard

extension UIViewController{
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
}

