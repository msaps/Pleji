//
//  Goal.swift
//  HomeSource
//
//  Created by Gary Butcher on 21/04/2016.
//  Copyright © 2016 Apadmi. All rights reserved.
//

import UIKit

class Goal: NSObject {
    //icon
    //title
    //targt
    //current
    //subtitle
    
    var icon: String?
    var title: String
    var target: Int
    var current: Int
    var subtitle: String
    var donationType : DonationType
    
    var suffix: (singular : String, plural : String)?
    var prefix: (singular : String, plural : String)?
    
    override init() {
        self.icon = nil // not icon
        self.title = "Sleeping bags"
        self.target = 100
        self.current = 28
        self.subtitle = "Warm weather sleeping bags"
        self.donationType = .Money
    }
    
    func getTargetString() -> String {
        return formatString(self.target)
    }
    
    func getCurrentString() -> String {
        return formatString(self.current)
    }
    
    func formatString(value : Int) -> String {
        var currentString = "";
        
        if let prefix = self.prefix {
            currentString += (value==1 ? prefix.singular : prefix.plural) + " "
        }
        
        currentString += String(value)
        
        if let suffix = self.suffix {
            currentString += " " + (value==1 ? suffix.singular : suffix.plural)
        }
        
        return currentString
    }
    
    func getPercentageOfGoal() -> Float {
        let percentage = Float(self.current) / Float(self.target)
        return percentage
    }
    
    func getTypeString() -> String {
        switch self.donationType {
        case .Material:
            return "Material Donation"
        case .Time:
            return "Service Donation"
        default:
            return "Donation"
        }
    }
}
