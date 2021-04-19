//
//  DateExtractor.swift
//  ExpenditureTracker
//
//  Created by Raghav Sharma on 05/01/17.
//  Copyright © 2017 Original Thinkers. All rights reserved.
//

import Foundation

class DateExtractor{
    
    func getExactDate() -> [String] {
        let currentDateTime = Date()
        let dateString = String(describing: currentDateTime)
        let subString = dateString.components(separatedBy: "-")
        let subsubString = subString[2].components(separatedBy: " ")
        return subsubString
    }
}
    
