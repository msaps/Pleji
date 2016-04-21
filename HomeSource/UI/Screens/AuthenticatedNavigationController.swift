//
//  ModalNavigationController.swift
//  HomeSource
//
//  Created by Merrick Sapsford on 21/04/2016.
//  Copyright © 2016 Apadmi. All rights reserved.
//

import UIKit

class AuthenticatedNavigationController: UINavigationController {
   
    var authenticated: Bool?
    
    // MARK - Init
    
    required init?(coder aDecoder: NSCoder) {
        self.authenticated = false
        super.init(coder: aDecoder)
        
        if (self.authenticated == false) {
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let signInViewController = storyboard.instantiateViewControllerWithIdentifier("SignInViewController") as! SignInViewController
            let currentViewControllerId = self.viewControllers.first?.restorationIdentifier
            
            signInViewController.successViewControllerIdentifier = currentViewControllerId
            self.viewControllers = [signInViewController]
        }
    }
    
}
