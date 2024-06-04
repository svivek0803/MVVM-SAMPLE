//
//  SearchTextField.swift
//  ExpatLand
//
//  Created by User on 16/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//


import Foundation
import UIKit

class SearchTextField : UITextField {
    let rightButton  = UIButton(type: .custom)
    
    public var actionKeyboardReturn: (() -> ())?
    
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
        rightButton.setImage(UIImage(named: "search") , for: .normal)
        rightButton.addTarget(self, action: #selector(didTapRightButton), for: .touchUpInside)
        rightButton.frame = CGRect(x:0, y:0, width:Int(self.frame.size.height / 2), height:Int(self.frame.size.height / 2))
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        rightViewMode = .always
        rightView = rightButton
        tintColor = Constants.Color.appDefaultColor
        self.backgroundColor = .white
        returnKeyType = .search
        self.delegate = self
        addShadow(radius: 4, cornerRadius: 2, color: Constants.Color.appDefaultColor)
        addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
    }
    
    @objc
    func didTapRightButton(button: UIButton) {
        
        if rightButton.imageView?.image == UIImage(named: "cross")
        {
            resetTextField()
        }
        else {
            actionKeyboardReturn?()
        }
    }
    
    func resetTextField()
    {
         text = ""
         rightButton.setImage(UIImage(named: "search") , for: .normal)
    }
   
}

extension SearchTextField: UITextFieldDelegate {
   
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if (textField.text?.trimFromLeading().isEmpty ?? false)
        {
            rightButton.setImage(UIImage(named: "search") , for: .normal)
        }
        else
        {
            rightButton.setImage(UIImage(named: "cross") , for: .normal)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          self.resignFirstResponder()
          actionKeyboardReturn?()
          return true
       }
}
