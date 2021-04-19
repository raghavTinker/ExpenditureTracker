//
//  ViewController.swift
//  ExpenditureTracker
//
//  Created by Raghav Sharma on 04/01/17.
//  Copyright © 2017 Original Thinkers. All rights reserved.
//

import UIKit
import AVFoundation
import UserNotifications

var audioPlayer = AVAudioPlayer()

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {
    var isMusicPlaying = Wallet.isMusicPlaying
    
    
    @IBOutlet weak var addExpenseOutlet: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var settingsOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Retrieving Data
        BasicFunctionality().retrieveData()
        BasicFunctionality().checkDate()
        checkWallet()
        var isMusicNeeded = Wallet.isMusicNeeded
        if isMusicNeeded == true{
            musicConfusion()
        }
        else{
            isMusicNeeded = false
            isMusicPlaying = false
            print("MUSIC NOT NEEDED")
        }
        
        BasicFunctionality().widgetFunctionality()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Retrieving Data
        BasicFunctionality().retrieveData()
        BasicFunctionality().checkDate()
        checkWallet()
        var isMusicNeeded = Wallet.isMusicNeeded
        if isMusicNeeded == true{
            musicConfusion()
        }
        else{
            isMusicNeeded = false
            isMusicPlaying = false
            print("MUSIC NOT NEEDED")
        }
        
       BasicFunctionality().widgetFunctionality()
    }
    
    func checkWallet(){
        if Wallet.moneyLeftInWallet == 0{
            if Wallet.moneyLeftInWallet == 0 && Wallet.moneyLimit == 0{
                statusLabel.text = "Your wallet needs to be filled up and you have not set your money spending limit."
                addExpenseOutlet.isEnabled = false
            }
            else{
                statusLabel.text = "Your wallet is empty. Why don't you consider filling it up?"
                addExpenseOutlet.isEnabled = false
            }
            
        }
        else{
            checkLimit()
        }
        
    }
    
    func checkLimit(){
        if Wallet.moneyLimit == 0{
            statusLabel.text = "You have not set your money limit. Please set it in the settings button"
            addExpenseOutlet.isEnabled = false
        }
        else{
            checkifLimitLeft()
        }
        
    }
    
    func checkifLimitLeft(){
        if Wallet.moneyLimit - Wallet.moneySpent <= 0{
            statusLabel.text = "You have exhausted your paying limit. You cannot add another expense."
            addExpenseOutlet.isEnabled = false
        }
    }
    
    func musicConfusion(){
        if isMusicPlaying{
            
        }
            
        else{
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
        }
    }
    
}

