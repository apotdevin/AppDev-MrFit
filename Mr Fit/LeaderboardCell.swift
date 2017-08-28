//
//  LeaderboardCell.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 5/19/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit

class LeaderboardCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var profilePicture: FBSDKProfilePictureView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width/2
        self.profilePicture.clipsToBounds = true
        
        self.profilePicture.layer.borderWidth = 3
        self.profilePicture.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
