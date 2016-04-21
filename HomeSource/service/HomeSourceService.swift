//
//  HomeSourceService.swift
//  HomeSource
//
//  Created by Gary Butcher on 21/04/2016.
//  Copyright © 2016 Apadmi. All rights reserved.
//

import UIKit
import SwiftyJSON
import DateTools

enum CampaignError : ErrorType {
    case DataNotFound
}

public class HomeSourceService: NSObject {
    
    private var mUser : User?
    private static var gInstance : HomeSourceService?
    
    ///MARK: Singleton access
    
    class func instance() -> HomeSourceService {
        if gInstance == nil {
            gInstance = HomeSourceService()
        }
        return gInstance!
    }
    
    ///MARK: User
    
    func isLoggedIn() -> Bool {
        return mUser != nil
    }
    
    func getUser() -> User? {
        return mUser
    }
    
    typealias AuthCompletionBlock =  (success: Bool, error: ErrorType?) -> Void
    
    func login(completion: AuthCompletionBlock){
        
        //TODO: Async login call
        mUser = User();
        completion(success: true, error: nil);
    }
    
    func logout(completion: AuthCompletionBlock){
        
        //TODO: Async logout call
        mUser = nil;
        completion(success: true, error: nil);
    }
    
    ///MARK: Campaigns
    
    typealias CampaignCompletionBlock = (campaigns: [Campaign]?, error: CampaignError?) -> Void
    
    func getCampaigns(completion: CampaignCompletionBlock) {
        
        /*guard let _ = getUser() else {
            print("Not logged in");
            return;
        }*/
        
        //TODO: Async call to fetch a list of campaigns.
        
        guard
            let path = NSBundle.mainBundle().pathForResource("campaigns", ofType: "json"),
            let jsonData = NSData(contentsOfFile: path) else {
                completion(campaigns: nil, error: .DataNotFound)
                return
        }
        
        let json = JSON(data: jsonData)
        
        var campaigns = [Campaign]()
        for (_, campaignData) in json["campaigns"] {
            
            guard
                let title = campaignData["title"].string,
                let description = campaignData["description"].string,
                let dateString = campaignData["endDate"].string,
                let endDate = dateFromISOString(dateString)
                else {
                    print("Invalid json object")
                    continue
            }
            
            let campaign = Campaign();
            campaign.title = title
            campaign.campaignDescription = description
            campaign.endDate = endDate
            campaigns.append(campaign)
            
            //add goals to out campaign
            
            for (_, goalData) in campaignData["goals"] {
                addGoal(campaign, goalData: goalData)
            }
        }
        
        completion(campaigns: campaigns, error: nil)
    }
    
    private func addGoal(campaign: Campaign, goalData: JSON) {
        
        guard
            let title = goalData["title"].string,
            let subtitle = goalData["subtitle"].string,
            let target = goalData["target"].int,
            let current = goalData["current"].int
            else {
                print("Invalid goal json object")
                return
        }
        
        let goal = Goal()
        goal.title = title
        goal.subtitle = subtitle
        goal.target = target
        goal.current = current
        if let singular = goalData["suffix"]["singular"].string,
            let plural = goalData["suffix"]["plural"].string {
            goal.suffix = (singular, plural)
        }
        if let singular = goalData["prefix"]["singular"].string,
            let plural = goalData["prefix"]["plural"].string {
            goal.prefix = (singular, plural)
        }
        campaign.goals.append(goal)
    }


    private func dateFromISOString(string: String) -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        return dateFormatter.dateFromString(string);
    }
}
