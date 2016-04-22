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
    @IBOutlet var statusBarOverlay: UIView?
    
    // MARK - Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView?.reloadData()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
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
            return (self.campaign?.goals.count ?? 0)
        default:
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        
        switch indexPath.section {

        case 0:
            let headerCell = collectionView.dequeueReusableCellWithReuseIdentifier("campaignHeaderCell", forIndexPath: indexPath) as! CampaignHeaderCell
            
            headerCell.backgroundImageView?.image = campaign?.image
            headerCell.titleLabel?.text = campaign?.title
            headerCell.subtitleLabel?.text = campaign?.organiser
            
            let progress = GradientCircularProgress()
            let progressView = progress.showAtRatio(frame: headerCell.progressContainerView!.bounds, display: true, style: CampaignDetailsCircularProgressStyle())
            progressView?.backgroundColor = UIColor.clearColor()
            
            let overallProgress = CGFloat(campaign?.getOverallProgress() ?? 0)
            progress.updateRatio(overallProgress)
            headerCell.progressLabel?.text = String(format: "%i%%",  NSInteger((overallProgress * 100)))
            
            headerCell.progressContainerView?.addSubview(progressView!)
            
            cell = headerCell
        
        default:
            let goalCell = collectionView.dequeueReusableCellWithReuseIdentifier("campaignGoalCell", forIndexPath: indexPath) as! CampaignGoalCell
            let goal = self.campaign!.goals[indexPath.row]
            
            goalCell.viewController = self
            goalCell.goal = goal
            goalCell.campaign = self.campaign
            
            goalCell.titleLabel?.text = (goal.title).uppercaseString
            goalCell.goalLabel?.text = goal.getTargetString()
            goalCell.typeLabel?.text = goal.getTypeString()
            
            var progressString: String
            if goal.current == goal.target {
                progressString = "Complete!"
                goalCell.pledgeButton?.enabled = false
                goalCell.pledgeButton?.setTitle("Complete!", forState: UIControlState.Normal)
            } else {
                let goalItem = (goal.target == 1) ? goal.suffix!.singular : goal.suffix!.plural
                progressString = String(format: "%i/%i %@", goal.current, goal.target, goalItem)
                goalCell.pledgeButton?.enabled = true
                goalCell.pledgeButton?.setTitle("Pledge", forState: UIControlState.Normal)
            }
            goalCell.progressLabel?.text = progressString
            
            let progress = GradientCircularProgress()
            let progressView = progress.showAtRatio(frame: goalCell.progressContainer!.bounds, display: true, style: CampaignDetailsProgressCellCircularProgressStyle())
            progressView?.backgroundColor = UIColor.clearColor()
            progress.updateRatio(CGFloat(goal.getPercentageOfGoal()))
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
    
    // MARK - UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset
        let yOffset = contentOffset.y
        
        if yOffset >= 240.0 {
            if self.statusBarOverlay?.alpha == 0.0 {
                UIView.animateWithDuration(0.25, animations: {
                    self.statusBarOverlay?.alpha = 1.0
                })
            }
        } else {
            if self.statusBarOverlay?.alpha == 1.0 {
                UIView.animateWithDuration(0.25, animations: { 
                    self.statusBarOverlay?.alpha = 0.0
                })
            }
        }
    }
}

class CampaignHeaderCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subtitleLabel: UILabel?
    
    @IBOutlet weak var progressContainerView: UIView?
    @IBOutlet weak var progressLabel: UILabel?

}

class CampaignGoalCell: UICollectionViewCell {
    
    // MARK - Properties
    
    @IBOutlet weak var titleLabel: UILabel?
    
    @IBOutlet weak var goalLabel: UILabel?
    
    @IBOutlet weak var typeLabel: UILabel?
    
    @IBOutlet weak var progressLabel: UILabel?
    @IBOutlet weak var progressContainer: UIView?
    
    @IBOutlet weak var pledgeButton: UIButton?
    
    var viewController: UIViewController?
    var goal: Goal?
    var campaign: Campaign?
    
    // MARK - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.pledgeButton?.addTarget(self, action: #selector(pledgeButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    @objc func pledgeButtonPressed(sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let authController = storyboard.instantiateViewControllerWithIdentifier("PledgeNavigationController") as! AuthenticatedNavigationController
        
        //TODO - these could be nil
        authController.attributes = [self.campaign!, self.goal!]
        
        if self.viewController != nil {
            self.viewController!.presentViewController(authController, animated: true, completion: nil)
        }
    }
}

public struct CampaignDetailsCircularProgressStyle : StyleProperty {
    /*** style properties **********************************************************************************/
    
    // Progress Size
    public var progressSize: CGFloat = 100
    
    // Gradient Circular
    public var arcLineWidth: CGFloat = 4
    public var startArcColor: UIColor = UIColor.greenColor()
    public var endArcColor: UIColor = UIColor.plejiGreen()
    
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
    public var endArcColor: UIColor = UIColor.plejiGreen()
    
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
