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
    
    private var heroImage: UIImage
    private var goals: [Goal]
    private var campaignDescription: String
    private var title: String
    private var logo: UIImage? //Images are optional at this point
    private var endDate: NSDate
    
    override init() {
        self.heroImage = UIImage(named: "")!
        self.goals = [Goal]()
        self.campaignDescription = "This is a test campaign"
        self.title = "We need people!"
        self.logo = nil;
        self.endDate = NSDate(timeIntervalSinceNow: 60 * 60 * 24 * 7)
    }
    
}
