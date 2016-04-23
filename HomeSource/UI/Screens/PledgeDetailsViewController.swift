//
//  PledgeDetailsViewController.swift
//  HomeSource
//
//  Created by Merrick Sapsford on 21/04/2016.
//  Copyright © 2016 Apadmi. All rights reserved.
//

import UIKit

class PledgeDetailsViewController: UIViewController {
    
    @IBOutlet weak var campaignImageView: UIImageView!
    @IBOutlet weak var campaignTitleLabel: UILabel!
    @IBOutlet weak var campaignOrganiserLabel: UILabel!
    @IBOutlet weak var goalTitleLabel: UILabel!
    @IBOutlet weak var donationValueLabel: UILabel!
    @IBOutlet weak var donationSlider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var pledgeButton: RoundRectButton!
    
    var campaign : Campaign?
    var goal : Goal?
    var value : Int = 1 {
        didSet {
            valueDidUpdate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
        
        //fetch data from root
        //Horrible!!!
        let controller = self.navigationController as! AuthenticatedNavigationController
        if let attributes = controller.attributes {
            self.campaign = attributes[0] as? Campaign
            self.goal = attributes[1] as? Goal
        }
        
        donationSlider.minimumValue = 1
        donationSlider.maximumValue = Float(goal!.target - goal!.current)
        donationSlider.value = 1
        
        //Slider listener for value change
        donationSlider.addTarget(self, action: #selector(PledgeDetailsViewController.sliderDidUpdate), forControlEvents: .ValueChanged)
        
        if donationSlider.maximumValue == 1 {
            donationSlider.hidden = true
            targetLabel.hidden = true
        }
        
        updateHeader()
        valueDidUpdate()
    }
    
    func updateHeader() {
        guard let campaign = self.campaign else {
            print("invalid input");
            return
        }
        
        campaignImageView.image = campaign.image
        campaignTitleLabel.text = campaign.title
        campaignOrganiserLabel.text = campaign.organiser
    }
    
    @IBAction func closeButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func sliderDidUpdate() {
        self.value = Int(donationSlider.value)
    }
    
    func valueDidUpdate() {
        
        guard let goal = self.goal else {
            print("No goal set");
            return
        }
        
        goalTitleLabel.text = goal.title
        
        donationValueLabel.text = goal.formatString(value)
        let remaining = goal.target - goal.current - self.value
        if remaining == 0 {
            targetLabel.text = "Thank you so much!"
        } else {
            targetLabel.text = "\(goal.formatString(remaining)) still needed"
        }
    }
    
    @IBAction func pledgeButtonPressed(sender: AnyObject) {
        
        if goal?.donationType == .Money {
            //Need to show the payment screen first
            //self.performSegueWithIdentifier("presentPaymentScreen", sender: nil)
            
            let alert = UIAlertController(title: "Payment",
                                          message: nil,
                                          preferredStyle: .ActionSheet)
            alert.addAction(UIAlertAction(title: "Pay", style: .Default, handler: { action in
                self.fakePayment()
            }))
            alert.addAction(UIAlertAction(title: "Paypal", style: .Default, handler: { action in
                self.fakePayment()
            }))
            alert.addAction(UIAlertAction(title: "Card", style: .Default, handler: { action in
                self.fakePayment()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
        }
        
        showThanks(.Material)
    }
    
    func showThanks(type: DonationType) {
        //update the campiagn object
        goal?.current += self.value
        
        var msg = "Every donation goes a long way in helping your city."
        if type != .Money {
            msg = "You will recieve an email with your reminder and QR code. Rememeber to bring this along with you.\n\nEvery donation goes a long way in helping your city."
        }
        
        let alert = UIAlertController(title: "Thank You!",
                                      message: msg,
                                      preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Share", style: .Default, handler: { action in
            self.shareDonation()
        }))
        alert.addAction(UIAlertAction(title: "Done", style: .Cancel, handler: { action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func fakePayment() {
        
        showThanks(.Money)
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
    
    ///MARK: segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "presentPaymentScreen" {
            let controller = segue.destinationViewController as! PaymentViewController
            controller.goal = self.goal
            controller.value = self.value
        }
    }
}
