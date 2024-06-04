//
//  TermsConditionsTVCell.swift
//  ExpatLand
//
//  Created by Neeraja Mohandas on 14/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import UIKit

class TermsConditionsTVCell: UITableViewCell {
    @IBOutlet var label_Title: UILabel!
    @IBOutlet var label_description: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label_description.sizeToFit()
        label_description.font = UIFont.kAppDefaultFontRegular(ofSize: 14)
        label_Title.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
