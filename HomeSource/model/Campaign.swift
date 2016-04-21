//
//  Campaign.swift
//  HomeSource
//
//  Created by Gary Butcher on 21/04/2016.
//  Copyright © 2016 Apadmi. All rights reserved.
//

import UIKit

class Campaign: NSObject {
    //Image
    //Array of goals
    //description
    //title
    //Logo / charity name
    //Date
    
    var image: String?
    var goals: [Goal]
    var campaignDescription: String
    var title: String
    var logo: UIImage? //Images are optional at this point
    var endDate: NSDate
    var organiser: String
    
    override init() {
        
        //Set up some dummy data
        self.image = nil
        self.goals = [Goal]()
        self.campaignDescription = "This is a test campaign"
        self.title = "We need people!"
        self.organiser = "Charity Test"
        self.logo = nil;
        self.endDate = NSDate(timeIntervalSinceNow: 60 * 60 * 24 * 7)
    }
    
}
