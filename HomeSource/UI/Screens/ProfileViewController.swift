//
//  ProfileViewController.swift
//  HomeSource
//
//  Created by Merrick Sapsford on 21/04/2016.
//  Copyright © 2016 Apadmi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var historyTableView: UITableView!
    
    private var history : [UserDonation]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
        
        updateView()
        
        if let user = HomeSourceService.instance().getUser() {
            self.history = user.getPreviousDonation()
        }
        
        historyTableView.reloadData()
    }
    
    private func updateView() {
        guard let user = HomeSourceService.instance().getUser() else {
            print("We need a user object for the profile.")
            return
        }
        
        userNameLabel.text = user.name
        //userImageView.image = user.image
        
        //TODO - load history items
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    ///MARK: tableview
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let history = self.history else {
            return 0
        }
        
        return history.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("historyCell", forIndexPath: indexPath) as! HistoryTableViewCell
        
        if let history = self.history {
            cell.userDontation = history[indexPath.row]
        }
        
        return cell
    }
}
