//
//  HomeSourceService.swift
//  HomeSource
//
//  Created by Gary Butcher on 21/04/2016.
//  Copyright © 2016 Apadmi. All rights reserved.
//

import UIKit

class HomeSourceService: NSObject {
    
    
    private var mUser : User?
    
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
    
    typealias CampaignCompletionBlock = (campaigns: [Campaign], error: ErrorType?) -> Void
    
    func getCampaigns(completion: CampaignCompletionBlock) {
        
        /*guard let _ = getUser() else {
            print("Not logged in");
            return;
        }*/
        
        //TODO: Async call to fetch a list of campaigns.
        
        var campaigns = [Campaign]()
        for _ in 0...10 {
            campaigns.append(Campaign())
        }
        
        completion(campaigns: campaigns, error: nil)
    }
}
