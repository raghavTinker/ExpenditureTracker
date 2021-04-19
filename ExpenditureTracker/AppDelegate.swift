//
//  AppDelegate.swift
//  ExpenditureTracker
//
//  Created by Raghav Sharma on 04/01/17.
//  Copyright © 2017 Original Thinkers. All rights reserved.
//
import UIKit
import AVFoundation
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            // Enable or disable features based on authorization.
        }
        let generalCategory = UNNotificationCategory(identifier: "ERASE_TRANSACTIONS",
                                                     actions: [],
                                                     intentIdentifiers: [],
                                                     options: .customDismissAction)
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Your transactions have been erased", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "A new month has started. Your prior month has transaction data has been erased.",
                                                                arguments: nil)
        //content.badge = 0
        
        // Configure the trigger
        var dateInfo = DateComponents()
        dateInfo.day = 01
        dateInfo.hour = 00
        dateInfo.minute = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
        
        // Create the request object.
        let request = UNNotificationRequest(identifier: "EraseTransactions", content: content, trigger: trigger)
        
        // Register the category.
        center.setNotificationCategories([generalCategory])
        
        // Schedule the request.
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
        alertTransactions()
        wishDeveloperHB()
        return true
    }
    
    func alertTransactions(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            // Enable or disable features based on authorization.
        }
        let generalCategory = UNNotificationCategory(identifier: "ALERT_TRANSACTIONS",
                                                     actions: [],
                                                     intentIdentifiers: [],
                                                     options: .customDismissAction)
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "The month is about to end", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "The month is about to end. Please review your transactions now!!",
                                                                arguments: nil)
        //content.badge = 0
        
        // Configure the trigger
        var dateInfo = DateComponents()
        dateInfo.day = BasicFunctionality().sendDate()
        dateInfo.hour = 06
        dateInfo.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
        
        // Create the request object.
        let request = UNNotificationRequest(identifier: "AlertTransactions", content: content, trigger: trigger)
        
        // Register the category.
        center.setNotificationCategories([generalCategory])
        
        // Schedule the request.
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
    }
    
    func wishDeveloperHB(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            // Enable or disable features based on authorization.
        }
        let generalCategory = UNNotificationCategory(identifier: "WISH_HB",
                                                     actions: [],
                                                     intentIdentifiers: [],
                                                     options: .customDismissAction)
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Happy Birthday Raghav Sharma!!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Wish the developer Raghav Sharma happy birthday!! Today is his birthday🎁🎂",
                                                                arguments: nil)
        
        // Configure the trigger for a 7am wakeup.
        var dateInfo = DateComponents()
        dateInfo.day = 17
        dateInfo.hour = 06
        dateInfo.minute = 030
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
        
        // Create the request object.
        let request = UNNotificationRequest(identifier: "WishRaghavHB", content: content, trigger: trigger)
        
        // Register the category.
        center.setNotificationCategories([generalCategory])
        
        // Schedule the request.
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        BasicFunctionality().saveData()
    }
    
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        if shortcutItem.type == "com.raghav.ExpenditureTracker.addExpense"{
            //Going to VC to add expense
            let vc = UIStoryboard(name: "Main", bundle: nil)
            let contact = vc.instantiateViewController(withIdentifier: "addExpenseVC") as! AddExpenseViewController
            self.window?.rootViewController?.present(contact, animated: true, completion: nil)
        }
        else if shortcutItem.type == "com.raghav.ExpenditureTracker.reviewTransactions"{
            //Going to VC to reviewtransactions
            let vc = UIStoryboard(name: "Main", bundle: nil)
            let contact = vc.instantiateViewController(withIdentifier: "reviewTransactions") as! ReviewTransactions
            self.window?.rootViewController?.present(contact, animated: true, completion: nil)
        }
    }
}

