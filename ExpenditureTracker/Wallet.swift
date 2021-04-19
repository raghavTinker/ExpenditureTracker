//
//  Wallet.swift
//  ExpenditureTracker
//
//  Created by Raghav Sharma on 07/01/17.
//  Copyright © 2017 Original Thinkers. All rights reserved.
//
import AVFoundation
struct Wallet{
    static var moneyLimit: Double = 0.0
    static var moneyLeftInWallet: Double = 0.0
    static var moneySpent: Double = 0.0
    
    //This variable will only be used in the first transaction of the month for 01
    static var isReset: Bool = false
    
    //This varibale is for isReset for 01
    static var isReset01: Bool = false
    
    //Label variables
    static var vegetables = 0.0
    static var grocery = 0.0
    static var shopping = 0.0
    static var entertainment = 0.0
    static var electronics = 0.0
    static var bills = 0.0
    static var travel = 0.0
    static var miscellaneous = 0.0
    
    //Music 
    static var isMusicPlaying = false
    static var isMusicNeeded = true
    
    //NotificationSent??
    static var notificationSent = false
}
