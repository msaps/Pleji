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
        self.titleTextAttributes = [NSFontAttributeName : UIFont.systemFontOfSize(20.0, weight: UIFontWeightLight)]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName : UIFont.systemFontOfSize(20.0, weight: UIFontWeightLight)],
                                                            forState: UIControlState.Normal)
    }
    
}
