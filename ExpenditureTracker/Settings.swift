//
//  Settings.swift
//  ExpenditureTracker
//
//  Created by Raghav Sharma on 28/01/17.
//  Copyright © 2017 Original Thinkers. All rights reserved.
//

import UIKit
import LocalAuthentication
import AVFoundation

class Settings: UIViewController{
    
    @IBAction func resetTButton(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Reset transactions", message: "Reset transactions will completely erase your previous transaction database. This actions cannot be undone.", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Reset Transactions", style: .destructive, handler: {(action: UIAlertAction) in self.resetTransactions()}))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)

    }
    func resetTransactions(){
        print("Hurray")
        BasicFunctionality().resetData()
    }
    
    
    
    @IBAction func resetWalletButton(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Empty Wallet", message: "Emptying wallet will completely erase your wallet. This action can't be undone", preferredStyle: .actionSheet)
        
        //Reset Button Destructive style
        actionSheet.addAction(UIAlertAction(title: "Empty Wallet", style: .destructive, handler: {(action: UIAlertAction) in self.resetWallet()}))
        
        //Cancel Button cancel style
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func resetWallet(){
        BasicFunctionality().resetWallet()
    }
    
    @IBAction func resetLimitButton(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Reset Spending Limit", message: "Resetting you wallet usage limit will reset the spending limit to ₹0.0. This action can't be undone.", preferredStyle: .actionSheet)
        
        //Reset Button Destructive style
        actionSheet.addAction(UIAlertAction(title: "Reset Spending Limit", style: .destructive, handler: {(action: UIAlertAction) in self.resetSpendingLimit()}))
        
        //Cancel Button cancel style
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    func resetSpendingLimit(){
        BasicFunctionality().resetSpendingLimit()
    }
    
    @IBAction func factoryResetButton(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Factory Reset", message: "Factory reset will clear you entire expense tracker data. This action can't be undone.", preferredStyle: .actionSheet)
        
        //Reset Button destructive Style
        actionSheet.addAction(UIAlertAction(title: "Factory Reset", style: .destructive, handler: {(action: UIAlertAction) in self.factoryResetAuthorize()}))
        
        //Cancel Button Cancel style
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func factoryResetAuthorize(){
        //Touch ID
        let isTouchID = BasicFunctionality().touchIDExists()
        //IF Device with touch ID enrolled and enabled
        if isTouchID{
            //Bringing up touch id pop up
            let context: LAContext = LAContext()
            context.localizedFallbackTitle = ""
            
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authorize Payment", reply: {(wasSuccesful: Bool, error) in
                if wasSuccesful{
                    OperationQueue.main.addOperation {
                        self.factoryReset()
                    }
                }
                else{
                    OperationQueue.main.addOperation {
                        let alert = UIAlertController(title: "Authorization Failed", message: "Authorization for factory reset failed", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }})
        }
        else{
            print("No touch id")
            factoryReset()
        }
    }
    func factoryReset(){
        let alert = UIAlertController(title: "Authorization Granted", message: "App has been successfully resetted", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        BasicFunctionality().factoryReset()
        BasicFunctionality().widgetFunctionality()
    }
    
    
    @IBAction func stopMusic(_ sender: Any) {
        if Wallet.isMusicPlaying{
            audioPlayer.stop()
            Wallet.isMusicNeeded = false
            Wallet.isMusicPlaying = false
            BasicFunctionality().saveData()
        }
        else{
            
        }
    }
    
    @IBAction func playMusic(_ sender: Any) {
        if Wallet.isMusicPlaying{
            audioPlayer.play()
            Wallet.isMusicNeeded = true
            BasicFunctionality().saveData()
        }
        else{
            
            //Audio setup
            let bgMusicURL:NSURL = Bundle.main.url(forResource: "sample", withExtension: "mp3")! as NSURL
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: bgMusicURL as URL)
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                Wallet.isMusicPlaying = true
            }
            catch{
                print(error)
            }
            
            //Playing Audio
            audioPlayer.currentTime = 0
            audioPlayer.play()
            Wallet.isMusicPlaying = true
            Wallet.isMusicNeeded = true
            BasicFunctionality().saveData()
        }
    }
    
    
    @IBAction func exitButtonAction(_ sender: Any) {
        BasicFunctionality().saveData()
        //self.dismiss(animated: true, completion: nil)
    }
}
