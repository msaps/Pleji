//
//  ColorButton.swift
//  HomeSource
//
//  Created by Gary Butcher on 21/04/2016.
//  Copyright © 2016 Apadmi. All rights reserved.
//

import UIKit

class ColorButton: UIButton {
    
    //TODO - designable vars
    let buttonColor = UIColor.whiteColor()
    let selectedColor = UIColor.lightGrayColor()
    let titleColor = UIColor.grayColor()
    
    override var selected: Bool {
        didSet {
            updateBackgroundColor()
        }
    }
    
    override var highlighted: Bool {
        didSet {
            updateBackgroundColor()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        setup()
    }
    
    private func setup() {
        self.setTitleColor(titleColor, forState: .Normal)
        self.layer.cornerRadius = self.bounds.height / 2
        
        updateBackgroundColor()
    }
    
    func updateBackgroundColor() {
        
        if self.selected || self.highlighted {
            self.backgroundColor = selectedColor;
        } else {
            self.backgroundColor = buttonColor;
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
