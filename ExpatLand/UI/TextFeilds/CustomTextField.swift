//
//  CustomTextField.swift
//  ExpatLand
//
//  Created by User on 02/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import UIKit


class CustomRegularTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        text = text?.localized()
        let size: CGFloat = CGFloat(tag == 0 ? 16 : tag)
        font = UIFont.kAppDefaultFontRegular(ofSize: size)
    }
    override func deleteBackward() {
        super.deleteBackward()
        
        _ = delegate?.textField?(self, shouldChangeCharactersIn: NSMakeRange(0, 0), replacementString: "")
    }
}
