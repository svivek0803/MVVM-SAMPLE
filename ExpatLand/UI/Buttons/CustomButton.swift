//
//  CustomButton.swift
//  ExpatLand
//
//  Created by User on 02/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//


import UIKit

class CustomRegularButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel?.text = titleLabel?.text?.localized()
        let size: CGFloat = CGFloat(tag == 0 ? 16 : tag)
        titleLabel?.font = UIFont.kAppDefaultFontRegular(ofSize: size)
        addPressAnimation()
    }
    
}


class CustomBoldButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel?.text = titleLabel?.text?.localized()
        let size: CGFloat = CGFloat(tag == 0 ? 16 : tag)
        titleLabel?.font = UIFont.kAppDefaultFontBold(ofSize: size)
        addPressAnimation()
    }
    
}

class CustomRegularSecondaryButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel?.text = titleLabel?.text?.localized()
        let size: CGFloat = CGFloat(tag == 0 ? 16 : tag)
        titleLabel?.font = UIFont.kAppDefaultFontRegular(ofSize: size)
        addPressAnimation()
    }
    
    override var isHighlighted: Bool {
            get {
                return super.isHighlighted
            }
            set {
                if newValue {
                    layer.borderColor = Constants.Color.appPressedStateColor.cgColor
                }
                else {
                    layer.borderColor = Constants.Color.appDefaultColor.cgColor
                }
                super.isHighlighted = newValue
            }
        }
}

class CustomLogoutButton: UIButton{
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel?.text = titleLabel?.text?.localized()
        //addPressAnimation()
    }
    override var isHighlighted: Bool{
        get {
            return super.isHighlighted
        }set{
            if newValue{
                self.setTitleColor(#colorLiteral(red: 0.03137254902, green: 0.4588235294, blue: 0.4941176471, alpha: 1), for: .normal)
            }else{
                self.setTitleColor(#colorLiteral(red: 0, green: 0.6235294118, blue: 0.6392156863, alpha: 1), for: .highlighted)
            }
            super.isHighlighted = newValue
        }
    }
    
}
class CustomRegularPrimaryButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel?.text = titleLabel?.text?.localized()
        let size: CGFloat = CGFloat(tag == 0 ? 16 : tag)
        titleLabel?.font = UIFont.kAppDefaultFontRegular(ofSize: size)
        addPressAnimation()
      
    }
    
    
   
    
    override var isHighlighted: Bool {
            get {
                return super.isHighlighted
            }
            set {
                if newValue {
                    if backgroundColor == Constants.Color.appDefaultColor
                    {
                        backgroundColor = Constants.Color.appPressedStateColor
                    }
                    layer.borderColor = Constants.Color.appPressedStateColor.cgColor
                   
                   
                   
                }
                else {
                    if  backgroundColor == Constants.Color.appPressedStateColor
                    {
                        backgroundColor = Constants.Color.appDefaultColor
                    }
                   
                    layer.borderColor = Constants.Color.appDefaultColor.cgColor
                }
                super.isHighlighted = newValue
            }
        }
   
}
