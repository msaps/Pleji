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
    
    @IBOutlet weak var signInButton: ColorButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        
        let titleString = "Manchester!\nYour comminuity\nneeds you."
        let range = (titleString as NSString).rangeOfString(" you.")
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 0
        style.maximumLineHeight = 26
        
        let title = NSMutableAttributedString(string: titleString)
        title.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: range)
        
        title.addAttribute(NSParagraphStyleAttributeName, value:style, range:NSMakeRange(0, titleString.characters.count))
        
        self.titleLabel.attributedText = title
        self.messageLabel.text = "Sign up and help out those that make\nour city the fantastic place it is."
        self.activityIndicator.stopAnimating()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK - Interaction
    
    @IBAction func signedInPressed(sender: AnyObject) {
        
        self.activityIndicator.startAnimating()
        self.signInButton.hidden = true
        
        HomeSourceService.instance().login({success, error in
            self.activityIndicator.stopAnimating()
            if let error = error {
                print(error)
                self.signInButton.hidden = false
            } else {
                self.showSuccessViewController()
            }
        })

    }
    
    // MARK - Internal
    
    func showSuccessViewController() {
        self.activityIndicator.stopAnimating()
        
        if self.successViewControllerIdentifier != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let viewController = storyboard.instantiateViewControllerWithIdentifier(self.successViewControllerIdentifier!)
            
            self.navigationController?.setViewControllers([viewController], animated: true)
        }
    }
    
    /*func changeRootViewController(viewController : UIViewController) {
        UIView.transitionWithView(self.view,
                                  duration: 0.5,
                                  options:.TransitionFlipFromLeft,
                                  animations: ( self.window.rootViewController = viewController ),
                                  completion: nil)
    }*/
}
