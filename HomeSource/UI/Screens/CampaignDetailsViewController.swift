//
//  CampainDetailsViewController.swift
//  HomeSource
//
//  Created by Merrick Sapsford on 21/04/2016.
//  Copyright © 2016 Apadmi. All rights reserved.
//

import UIKit

class CampaignDetailsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // MARK - Properties
    
    var campaign: Campaign?
    @IBOutlet var collectionView: UICollectionView?
    
    // MARK - Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        
        switch indexPath.section {

        default:
            let headerCell = collectionView.dequeueReusableCellWithReuseIdentifier("campaignHeaderCell", forIndexPath: indexPath) as! CampaignHeaderCell
            
            headerCell.backgroundImageView?.image = UIImage(named: "hero_image_header")
            
            cell = headerCell
        }
        
        return cell
    }
    
    // MARK - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let insets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let width = collectionView.bounds.size.width - insets
        
        switch indexPath.section {
        case 0:
            return CGSizeMake(width, 240)
        default:
            return CGSizeMake(width, 80)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsetsZero
        default:
            return UIEdgeInsetsMake(12, 12, 12, 12)
        }
    }
}

class CampaignHeaderCell: UICollectionViewCell {
    
    @IBOutlet var backgroundImageView: UIImageView?
}