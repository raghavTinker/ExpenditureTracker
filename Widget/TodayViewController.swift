//
//  TodayViewController.swift
//  Widget
//
//  Created by Raghav Sharma on 25/02/17.
//  Copyright © 2017 Original Thinkers. All rights reserved.
//

import UIKit
import NotificationCenter
class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        getMoneyLeft()
        getLimitLeft()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        completionHandler(NCUpdateResult.newData)
    }
    
    //Widget main headings
    @IBOutlet weak var moneyLeft: UILabel!
    @IBOutlet weak var limitLeft: UILabel!
    
    
    func getMoneyLeft(){
        if let textFromApp = UserDefaults.init(suiteName: "group.Raghav.ExpenditureTracker")?.value(forKey: "moneyLeft"){
            self.moneyLeft.text = "\(textFromApp)"
        }
        else{
            self.moneyLeft.text = "0"
        }
    }
    func getLimitLeft(){
        if let textFromApp = UserDefaults.init(suiteName: "group.Raghav.ExpenditureTracker")?.value(forKey: "limitLeft"){
            self.limitLeft.text = "\(textFromApp)"
        }
        else{
            self.limitLeft.text = "0"
        }
    }
    
    func widgetMarginInsets(forProposedMarginInsets defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        let margin = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        return margin
    }
}
