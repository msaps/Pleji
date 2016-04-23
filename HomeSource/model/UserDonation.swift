//
//  UserDontation.swift
//  HomeSource
//
//  Created by Gary Butcher on 21/04/2016.
//  Copyright © 2016 Apadmi. All rights reserved.
//

import UIKit

class UserDonation: NSObject {

    var goal : Goal
    var value : Int
    var date : NSDate
    
    init(goal: Goal, value : Int, date : NSDate) {
        self.goal = goal
        self.value = value
        self.date = date
        
        super.init()
    }
    
    func getTitle() -> String {
        return goal.formatString(value)
    }
}
