//
//  DiscoverViewController.swift
//  HomeSource
//
//  Created by Merrick Sapsford on 21/04/2016.
//  Copyright © 2016 Apadmi. All rights reserved.
//

import UIKit
import GradientCircularProgress

class DiscoverViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // MARK - Properties
    @IBOutlet var collectionView: UICollectionView?
    var campaigns: Array<Campaign>?
    
    // MARK - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HomeSourceService.instance().getCampaigns { (campaigns, error) in
            if error == nil {
                self.campaigns = campaigns
                self.collectionView?.reloadData()
            }
        }
    }
    
    // MARK - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.campaigns?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("campaignCell", forIndexPath: indexPath) as! DiscoverCollectionViewCell
        let campaign = self.campaigns![indexPath.row]
        
        cell.titleLabel?.text = campaign.title
        cell.detailsLabel?.text = campaign.campaignDescription
        cell.imageView?.image = UIImage(named: "logo")
        cell.backgroundImageView?.image = UIImage(named: "hero_image_header")
        
        let progress = GradientCircularProgress()
        let progressView = progress.showAtRatio(frame: cell.progressView!.bounds, display: true, style: MyStyle())
        progressView?.backgroundColor = UIColor.clearColor()
        progress.updateRatio(0.4)
        cell.progressView?.addSubview(progressView!)

        return cell
    }
    
    // MARK - UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let sectionInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        return CGSizeMake(collectionView.frame.width - sectionInsets, 120)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2.0;
    }
    
}

class DiscoverCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var detailsLabel: UILabel?
    @IBOutlet var backgroundImageView: UIImageView?
    
    @IBOutlet var progressView: UIView?
}

public struct MyStyle : StyleProperty {
    /*** style properties **********************************************************************************/
    
    // Progress Size
    public var progressSize: CGFloat = 80
    
    // Gradient Circular
    public var arcLineWidth: CGFloat = 6
    public var startArcColor: UIColor = UIColor.greenColor()
    public var endArcColor: UIColor = UIColor.greenColor()
    
    // Base Circular
    public var baseLineWidth: CGFloat? = 6
    public var baseArcColor: UIColor? = UIColor.whiteColor().colorWithAlphaComponent(0.6)
    
    // Ratio
    public var ratioLabelFont: UIFont? = UIFont(name: "Verdana-Bold", size: 0)
    public var ratioLabelFontColor: UIColor? = UIColor.whiteColor()
    
    // Message
    public var messageLabelFont: UIFont? = UIFont.systemFontOfSize(16.0)
    public var messageLabelFontColor: UIColor? = UIColor.whiteColor()
    
    // Background
    public var backgroundStyle: BackgroundStyles = .None
    
    /*** style properties **********************************************************************************/
    
    public init() {}
}