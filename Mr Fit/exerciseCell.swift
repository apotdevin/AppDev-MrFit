//
//  exerciseCell.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 3/28/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit

class exerciseCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var exerciseImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
