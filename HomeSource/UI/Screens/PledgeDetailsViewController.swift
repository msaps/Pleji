//
//  PledgeDetailsViewController.swift
//  HomeSource
//
//  Created by Merrick Sapsford on 21/04/2016.
//  Copyright © 2016 Apadmi. All rights reserved.
//

import UIKit

class PledgeDetailsViewController: UIViewController {
    
    var goal : Goal?
    var value : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Slider listener for value change
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
