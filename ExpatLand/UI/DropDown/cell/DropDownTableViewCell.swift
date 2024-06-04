//
//  DropDownTableViewCell.swift
//  ExpatLand
//
//  Created by User on 08/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import UIKit

class DropDownTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var indicatorView : UIView!
    @IBOutlet weak var mainView : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        indicatorView.makeRounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
