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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!

    @IBOutlet weak var facebookSignInButton: UIButton!
    @IBOutlet weak var facebookActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var facebookImageView: UIImageView!
    
    @IBOutlet weak var twitterSignInButton: UIButton!
    @IBOutlet weak var twitterActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var twitterImageView: UIImageView!
    
    // MARK - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        
        let titleString = "Find incredible\ncauses you love."
        let range = (titleString as NSString).rangeOfString("love")
        //let titleString = "Manchester!\nYour comminuity\nneeds you."

        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 0
        style.maximumLineHeight = 34
        
        let title = NSMutableAttributedString(string: titleString)
        title.addAttribute(NSForegroundColorAttributeName, value: UIColor.plejiGreen(), range: range)
        
        title.addAttribute(NSParagraphStyleAttributeName, value:style, range:NSMakeRange(0, titleString.characters.count))
        
        self.titleLabel.attributedText = title
        self.messageLabel.text = "We help you to find local campaigns\nand worthwhile causes you will love."
        self.twitterActivityIndicator.stopAnimating()
        self.facebookActivityIndicator.stopAnimating()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK - Interaction
    
    @IBAction func twitterSignInPressed(sender: AnyObject) {
        self.twitterActivityIndicator.startAnimating()
        self.twitterSignInButton.hidden = true
        self.twitterImageView.hidden = true
        self.facebookSignInButton.userInteractionEnabled = false
        
        self.signedInPressed(sender)
    }
    
    @IBAction func facebookSignInPressed(sender: AnyObject) {
        self.facebookActivityIndicator.startAnimating()
        self.facebookSignInButton.hidden = true
        self.facebookImageView.hidden = true
        self.twitterSignInButton.userInteractionEnabled = false
        
        self.signedInPressed(sender)
    }
    
    @IBAction func signedInPressed(sender: AnyObject) {

        HomeSourceService.instance().login({success, error in
            self.facebookActivityIndicator.stopAnimating()
            self.twitterActivityIndicator.stopAnimating()

            if let error = error {
                print(error)
                self.facebookSignInButton.hidden = false
                self.facebookImageView.hidden = false
                self.twitterSignInButton.hidden = false
                self.twitterImageView.hidden = false
            } else {
                self.showSuccessViewController()
            }
        })

    }
    
    // MARK - Internal
    
    func showSuccessViewController() {
        self.twitterActivityIndicator.stopAnimating()
        self.facebookActivityIndicator.stopAnimating()
        
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
