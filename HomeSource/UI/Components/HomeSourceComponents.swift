//
//  HomeSourceComponents.swift
//  HomeSource
//
//  Created by Merrick Sapsford on 21/04/2016.
//  Copyright © 2016 Apadmi. All rights reserved.
//

import UIKit

class HomeSourceNavigationBar: UINavigationBar {
    
    override func awakeFromNib() {
        self.titleTextAttributes = [NSFontAttributeName : UIFont.systemFontOfSize(20.0, weight: UIFontWeightLight), NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        self.barTintColor = UIColor(red: 0.259, green: 0.816, blue: 0.365, alpha: 1.0)
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [NSFontAttributeName : UIFont.systemFontOfSize(18.0, weight: UIFontWeightLight),
                NSForegroundColorAttributeName : UIColor.whiteColor()],
                                                            forState: UIControlState.Normal)
    }
    
}
