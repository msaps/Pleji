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
    
    private var icon: UIImage
    private var title: String
    private var target: Int
    private var current: Int
    private var subtitle: String
    
    override init() {
        self.icon = UIImage(named: "")!
        self.title = "Sleeping bags"
        self.target = 100
        self.current = 28
        self.subtitle = "Warm weather sleeping bags"
    }
    
}
