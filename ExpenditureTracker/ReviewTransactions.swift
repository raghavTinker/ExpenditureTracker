//
//  ReviewTransactions.swift
//  ExpenditureTracker
//
//  Created by Raghav Sharma on 05/01/17.
//  Copyright © 2017 Original Thinkers. All rights reserved.
//

import UIKit

class ReviewTransactions: UIViewController{
    
    @IBOutlet weak var bills: UILabel!
    @IBOutlet weak var grocery: UILabel!
    @IBOutlet weak var vegetables: UILabel!
    @IBOutlet weak var electronics: UILabel!
    @IBOutlet weak var travel: UILabel!
    @IBOutlet weak var shopping: UILabel!
    @IBOutlet weak var entertainment: UILabel!
    @IBOutlet weak var misc: UILabel!
    @IBOutlet weak var moneyInWallet: UILabel!
    @IBOutlet weak var limitLeft: UILabel!
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        BasicFunctionality().retrieveData()
        bills.text = "\(Wallet.bills)"
        grocery.text = "\(Wallet.grocery)"
        vegetables.text = "\(Wallet.vegetables)"
        electronics.text = "\(Wallet.electronics)"
        travel.text = "\(Wallet.travel)"
        shopping.text = "\(Wallet.shopping)"
        entertainment.text = "\(Wallet.entertainment)"
        misc.text = "\(Wallet.miscellaneous)"
        
        moneyInWallet.text = "\(Wallet.moneyLeftInWallet)"
        
        limitLeft.text = "\(Wallet.moneyLimit - Wallet.moneySpent)"
    }
    
    @IBAction func exitButtonAction(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil)
    }
}
