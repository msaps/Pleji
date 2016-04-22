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
        
        print("min: \(donationSlider.minimumValue). max: \(donationSlider.maximumValue)")
        
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
        
        campaignImageView.image = UIImage(named: "hero_image_header")
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
        
        donationValueLabel.text = goal.formatString(value)
        let remaining = goal.target - goal.current - self.value
        targetLabel.text = "\(remaining) still needed"
    }
    
    @IBAction func pledgeButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
        self.presentViewController(shareVC, animated: true, completion: nil)
    }
    
}
