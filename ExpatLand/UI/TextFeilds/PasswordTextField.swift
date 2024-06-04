//
//  PasswordTextField.swift
//  ExpatLand
//
//  Created by User on 03/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import UIKit

class PasswordTextField : UITextField {
    let rightButton  = UIButton(type: .custom)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        text = text?.localized()
        let size: CGFloat = CGFloat(tag == 0 ? 16 : tag)
        font = UIFont.kAppDefaultFontRegular(ofSize: size)
    }
    
    func commonInit() {
        rightButton.setImage(UIImage(named: "hide") , for: .normal)
        rightButton.addTarget(self, action: #selector(toggleShowHide), for: .touchUpInside)
        rightButton.frame = CGRect(x:0, y:0, width:Int(self.frame.size.height / 2), height:Int(self.frame.size.height / 2))
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        rightViewMode = .always
        rightView = rightButton
        isSecureTextEntry = true
        
        setLeftViewImage(img: UIImage(named: "password")!)
        addShadow(radius: 4, cornerRadius: 2, color: Constants.Color.appDefaultColor)
        
    }
    
    @objc
    func toggleShowHide(button: UIButton) {
        toggle()
    }
    
    func toggle() {
        isSecureTextEntry = !isSecureTextEntry
        if isSecureTextEntry {
            rightButton.setImage(UIImage(named: "hide") , for: .normal)
        } else {
            rightButton.setImage(UIImage(named: "unHide") , for: .normal)
        }
    }
}
