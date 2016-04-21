//
//  User.swift
//  HomeSource
//
//  Created by Gary Butcher on 21/04/2016.
//  Copyright © 2016 Apadmi. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String
    
    override init() {
        name = "Gary Butcher";
    }
    
    func getPreviousDonation() -> [UserDonation] {
        
        let goals : [Goal] = [ Goal(), Goal(), Goal() ]
        goals[0].title = "Goal Title"
        goals[0].subtitle = "Goal"
        goals[0].target = 100
        goals[0].current = 100
        goals[0].donationType = .Money
        goals[0].prefix = ("£", "£")
        
        goals[1].title = "Goal Title"
        goals[1].subtitle = "Goal"
        goals[1].target = 100
        goals[1].current = 100
        goals[1].donationType = .Time
        goals[1].suffix = ("Hour", "Hours")
        
        goals[2].title = "Goal Title"
        goals[2].subtitle = "Goal"
        goals[2].target = 100
        goals[2].current = 100
        goals[2].donationType = .Material;
        goals[2].suffix = ("Sock", "Socks")
        
        var donations = [UserDonation]()
        for i in 0...13 {
            let timeInterval = Double(i * (60 * 60 * 24 * 4)) //four days between donations?
            donations.append(UserDonation(goal: goals[i%3], value: 10, date: NSDate(timeIntervalSinceNow: timeInterval)))
        }
        return donations
    }
}
