//
//  PaymentViewController.swift
//  HomeSource
//
//  Created by Gary Butcher on 22/04/2016.
//  Copyright © 2016 Apadmi. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var applePayButton: UIButton!
    @IBOutlet weak var paypalButton: UIButton!
    @IBOutlet weak var cardButton: UIButton!
    
    var goal : Goal?
    var value : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func applePayButtonPressed(sender: AnyObject) {
        processPayment()
    }
    
    @IBAction func paypalButtonPressed(sender: AnyObject) {
        processPayment()
    }
    
    @IBAction func cardButtonPressed(sender: AnyObject) {
        processPayment()
    }
    
    
    func processPayment() {
        //update the campiagn object
        goal?.current += self.value
        
        let alert = UIAlertController(title: "Thank You! Share the love?",
                                      message: "Every donation goes a long way in helping your city.",
                                      preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Share", style: .Default, handler: { action in
            self.shareDonation()
        }))
        alert.addAction(UIAlertAction(title: "No thank you", style: .Cancel, handler: { action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func shareDonation() {
        
        guard let goal = self.goal else {
            print("No goal set");
            return
        }
        
        let shareTitle = "I have just donated " + goal.formatString(value)
        let url = NSURL(string: "http://www.barnabus-manchester.org.uk")!
        let image: UIImage = UIImage(named: "SocialIcon")!
        
        let shareVC: UIActivityViewController = UIActivityViewController(activityItems: [image, shareTitle, url], applicationActivities: nil)
        shareVC.completionWithItemsHandler = { _, _, _, _ in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        self.presentViewController(shareVC, animated: true, completion: nil)
    }
    
}
