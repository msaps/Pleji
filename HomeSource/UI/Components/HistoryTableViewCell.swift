//
//  HistoryTableViewCell.swift
//  HomeSource
//
//  Created by Gary Butcher on 21/04/2016.
//  Copyright © 2016 Apadmi. All rights reserved.
//

import UIKit
import DateTools

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var donationTypeImageView: UIImageView!
    @IBOutlet weak var donationTitleLabel: UILabel!
    @IBOutlet weak var donationDateLabel: UILabel!
    
    var userDontation : UserDonation? {
        didSet {
            updateCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        clearCell()
    }
    
    private func clearCell() {
        
        donationTypeImageView.image = UIImage(named: "clock")
        donationTitleLabel.text = nil
        donationDateLabel.text = nil
    }
    
    private func updateCell() {
        clearCell()
        
        guard let userDontation = self.userDontation else {
            return
        }
        
        switch userDontation.goal.donationType {
        case .Time:
            donationTypeImageView.image = UIImage(named: "clock")
        case .Money:
            donationTypeImageView.image = UIImage(named: "money")
        case .Material:
            donationTypeImageView.image = UIImage(named: "clock") //TODO: image for material
        }
        
        donationTitleLabel.text = userDontation.getTitle()
        donationDateLabel.text = userDontation.date.timeAgoSinceNow()
    }
}
