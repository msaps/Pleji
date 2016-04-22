//
//  HomeSourceComponents.swift
//  HomeSource
//
//  Created by Merrick Sapsford on 21/04/2016.
//  Copyright © 2016 Apadmi. All rights reserved.
//

import UIKit
import GradientCircularProgress

class HomeSourceNavigationBar: UINavigationBar {
    
    override func awakeFromNib() {
        self.titleTextAttributes = [NSFontAttributeName : UIFont.systemFontOfSize(20.0, weight: UIFontWeightLight), NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        self.barTintColor = UIColor(red: 0.259, green: 0.816, blue: 0.365, alpha: 1.0)
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [NSFontAttributeName : UIFont.systemFontOfSize(18.0, weight: UIFontWeightLight),
                NSForegroundColorAttributeName : UIColor.whiteColor()],
                                                            forState: UIControlState.Normal)
    }
    
}

class CircularView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.bounds.size.width / 2.0
    }
}

class RoundRectButton: UIButton {
    
    @IBInspectable var normalBackgroundColor: UIColor? {
        willSet {
            self.backgroundColor = newValue
        }
    }
    @IBInspectable var highlightBackgroundColor: UIColor?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.normalBackgroundColor = self.backgroundColor!
        self.highlightBackgroundColor = self.backgroundColor!.colorWithAlphaComponent(0.75)
    }
    
    override var highlighted: Bool {
        willSet {
            UIView.animateWithDuration(0.25) { 
                self.backgroundColor = newValue ? self.highlightBackgroundColor : self.normalBackgroundColor
            }
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 4.0
    }
}

public struct HomeSourceCircularProgressStyle : StyleProperty {
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