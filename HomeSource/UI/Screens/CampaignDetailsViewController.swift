//
//  CampainDetailsViewController.swift
//  HomeSource
//
//  Created by Merrick Sapsford on 21/04/2016.
//  Copyright © 2016 Apadmi. All rights reserved.
//

import UIKit
import GradientCircularProgress

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
    
    // MARK - Interaction
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        
        switch indexPath.section {

        case 0:
            let headerCell = collectionView.dequeueReusableCellWithReuseIdentifier("campaignHeaderCell", forIndexPath: indexPath) as! CampaignHeaderCell
            
            headerCell.backgroundImageView?.image = UIImage(named: "hero_image_header")
            headerCell.titleLabel?.text = campaign?.title
            headerCell.subtitleLabel?.text = campaign?.organiser
            
            let progress = GradientCircularProgress()
            let progressView = progress.showAtRatio(frame: headerCell.progressContainerView!.bounds, display: true, style: CampaignDetailsCircularProgressStyle())
            progressView?.backgroundColor = UIColor.clearColor()
            progress.updateRatio(0.4)
            headerCell.progressContainerView?.addSubview(progressView!)
            
            cell = headerCell
        
        default:
            let goalCell = collectionView.dequeueReusableCellWithReuseIdentifier("campaignGoalCell", forIndexPath: indexPath) as! CampaignGoalCell
            
            let progress = GradientCircularProgress()
            let progressView = progress.showAtRatio(frame: goalCell.progressContainer!.bounds, display: true, style: CampaignDetailsProgressCellCircularProgressStyle())
            progressView?.backgroundColor = UIColor.clearColor()
            progress.updateRatio(0.4)
            goalCell.progressContainer?.addSubview(progressView!)
            
            cell = goalCell
            
        }
        
        return cell
    }
    
    // MARK - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let sectionInset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAtIndex: indexPath.section)
        let insets = sectionInset.left + sectionInset.right
        let width = collectionView.bounds.size.width - insets
        
        switch indexPath.section {
        case 0:
            return CGSizeMake(width, 290)
        case 1:
            return CGSizeMake(width, 310)
        default:
            return CGSizeMake(width, 80)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsetsZero
        case 1:
            return UIEdgeInsetsMake(0.0, 0.0, 12, 0.0)
        default:
            return UIEdgeInsetsMake(12, 0.0, 12, 0.0)
        }
    }
}

class CampaignHeaderCell: UICollectionViewCell {
    
    @IBOutlet var backgroundImageView: UIImageView?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var subtitleLabel: UILabel?
    
    @IBOutlet var progressContainerView: UIView?
    @IBOutlet var progressLabel: UILabel?

}

class CampaignGoalCell: UICollectionViewCell {
    
    @IBOutlet var goalLabel: UILabel?
    
    @IBOutlet var typeImage: UIImage?
    @IBOutlet var typeLabel: UILabel?
    
    @IBOutlet var progressLabel: UILabel?
    @IBOutlet var progressContainer: UIView?
    
    @IBOutlet var pledgeButton: UIButton?
}

public struct CampaignDetailsCircularProgressStyle : StyleProperty {
    /*** style properties **********************************************************************************/
    
    // Progress Size
    public var progressSize: CGFloat = 100
    
    // Gradient Circular
    public var arcLineWidth: CGFloat = 4
    public var startArcColor: UIColor = UIColor.greenColor()
    public var endArcColor: UIColor = UIColor.greenColor()
    
    // Base Circular
    public var baseLineWidth: CGFloat? = 4
    public var baseArcColor: UIColor? = UIColor.clearColor()
    
    // Ratio
    public var ratioLabelFont: UIFont? = UIFont.systemFontOfSize(0.0, weight: UIFontWeightLight)
    public var ratioLabelFontColor: UIColor? = UIColor.whiteColor()
    
    // Message
    public var messageLabelFont: UIFont? = UIFont.systemFontOfSize(16.0)
    public var messageLabelFontColor: UIColor? = UIColor.whiteColor()
    
    // Background
    public var backgroundStyle: BackgroundStyles = .None
    
    /*** style properties **********************************************************************************/
    
    public init() {}
}

public struct CampaignDetailsProgressCellCircularProgressStyle : StyleProperty {
    /*** style properties **********************************************************************************/
    
    // Progress Size
    public var progressSize: CGFloat = 30
    
    // Gradient Circular
    public var arcLineWidth: CGFloat = 4
    public var startArcColor: UIColor = UIColor.greenColor()
    public var endArcColor: UIColor = UIColor.greenColor()
    
    // Base Circular
    public var baseLineWidth: CGFloat? = 4
    public var baseArcColor: UIColor? = UIColor.lightGrayColor()
    
    // Ratio
    public var ratioLabelFont: UIFont? = UIFont.systemFontOfSize(0.0, weight: UIFontWeightLight)
    public var ratioLabelFontColor: UIColor? = UIColor.whiteColor()
    
    // Message
    public var messageLabelFont: UIFont? = UIFont.systemFontOfSize(16.0)
    public var messageLabelFontColor: UIColor? = UIColor.whiteColor()
    
    // Background
    public var backgroundStyle: BackgroundStyles = .None
    
    /*** style properties **********************************************************************************/
    
    public init() {}
}
