//
//  SignInViewController.swift
//  HomeSource
//
//  Created by Merrick Sapsford on 21/04/2016.
//  Copyright © 2016 Apadmi. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    var successViewControllerIdentifier: String?
    
    
    // MARK - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK - Interaction
    
    @IBAction func signedInPressed(sender: AnyObject) {
        self.showSuccessViewController()
    }
    
    // MARK - Internal
    
    func showSuccessViewController() {
        if self.successViewControllerIdentifier != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let viewController = storyboard.instantiateViewControllerWithIdentifier(self.successViewControllerIdentifier!)
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
