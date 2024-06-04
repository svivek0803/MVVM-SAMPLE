//
//  PasswordView.swift
//  ExpatLand
//
//  Created by User on 07/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import UIKit

class PasswordView: UIView {
    
    // MARK: PROPERTIES -
    
    let errorLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = Validation.errorEmptyTextFeild
        l.isHidden = true
        l.font = UIFont.kAppDefaultFontRegular(ofSize: 12)
        l.textColor = Constants.Color.appDefaultErrorColor
        l.numberOfLines = 0
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    let textfield: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.addShadow(radius: 4, cornerRadius: 2, color: Constants.Color.appDefaultColor)
        tf.setLeftViewImage(img: UIImage(named: "password")!)
        tf.textColor = Constants.Color.appBaseBalticColor
        tf.font = UIFont.kAppDefaultFontRegular(ofSize: 14)
        tf.tintColor = Constants.Color.appBaseBalticColor
        tf.placeholder = Constants.TextConstant.password
        tf.rightViewMode = .always
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 8
        sv.distribution = .fill
        sv.alignment = .fill
        return sv
    }()
    
    
    let rightButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "hide") , for: .normal)
        btn.imageView?.tintColor = Constants.Color.appDefaultColor
        btn.addTarget(self, action: #selector(toggleShowHide), for: .touchUpInside)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        return btn
    }()
    
    public var actionKeyboardReturn: (() -> ())?
    
    // MARK: MAIN -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
        setUpConstraints()
    }
    
    
    // MARK: FUNCTIONS -
    
    func setUpViews(){
        addSubview(stackView)
        stackView.addArrangedSubview(textfield)
        stackView.addArrangedSubview(errorLabel)
        rightButton.frame = CGRect(x:0, y:0, width:Int(textfield.frame.size.height / 2), height:Int(self.frame.size.height / 2))
        textfield.rightView = rightButton
        textfield.delegate = self
    }
    
    func setUpConstraints(){
        stackView.pin(to: self)
        textfield.heightAnchor.constraint(equalToConstant: 53).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    @objc
    func toggleShowHide(button: UIButton) {
        toggle()
    }
    
    func toggle() {
        textfield.isSecureTextEntry = !textfield.isSecureTextEntry
        if textfield.isSecureTextEntry {
            rightButton.setImage(UIImage(named: "hide") , for: .normal)
        } else {
            rightButton.setImage(UIImage(named: "unHide") , for: .normal)
        }
    }
    
  
    
}

extension PasswordView {
    
    
    
    func showError(error: String)
    {
        textfield.makeBorder(1, color: Constants.Color.appDefaultErrorColor ,clipsToBounds: false)
        textfield.setLeftViewImage(img: UIImage(named: "passwordRed")!)
        errorLabel.text = error
        errorLabel.isHidden = false
        rightButton.imageView?.tintColor = Constants.Color.appDefaultErrorColor
    }
    
    func showError()
    {
        textfield.makeBorder(1, color: Constants.Color.appDefaultErrorColor ,clipsToBounds: false)
        textfield.setLeftViewImage(img: UIImage(named: "passwordRed")!)
        errorLabel.isHidden = true
        rightButton.imageView?.tintColor = Constants.Color.appDefaultErrorColor
    }
    
    func hideError()
    {
        textfield.setLeftViewImage(img: UIImage(named: "password")!)
        textfield.makeBorder(0, color: Constants.Color.appDefaultErrorColor ,clipsToBounds: false)
        errorLabel.isHidden = true
        rightButton.imageView?.tintColor = Constants.Color.appDefaultColor
      
    }
    
    func showConfirmPasswordError(error: String)
    {
        textfield.makeBorder(1, color: Constants.Color.appDefaultErrorColor ,clipsToBounds: false)
        textfield.setLeftViewImage(img: UIImage(named: "confirmPasswordRed")!)
        errorLabel.text = error
        errorLabel.isHidden = false
        rightButton.imageView?.tintColor = Constants.Color.appDefaultErrorColor
    }
    
    func hideConfirmPasswordError()
    {
        textfield.setLeftViewImage(img: UIImage(named: "confirmPassword")!)
        textfield.makeBorder(0, color: Constants.Color.appDefaultErrorColor ,clipsToBounds: false)
        errorLabel.isHidden = true
        rightButton.imageView?.tintColor = Constants.Color.appDefaultColor
      
    }
    
    func validate()->Bool
    {
        if textfield.text?.trimFromLeading().isEmpty ?? false
        {
            showError(error: Validation.errorEmptyTextFeild)
            return false
        }
        else if ((textfield.text?.count ?? 0 < 6))
        {
            showError(error: Validation.errorPasswordLengthInvalid)
            return false
        }
        
        hideError()
        return true
    }
    
    func validateWithoutCountCheck()->Bool
    {
        if textfield.text?.trimFromLeading().isEmpty ?? false
        {
            showError(error: Validation.errorEmptyTextFeild)
            return false
        }
      
        hideError()
        return true
    }
    
}

//MARK:UITextFeildDelegate
//==============
extension PasswordView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard !textField.hasError() else { return }
        textfield.makeBorder(1, color: Constants.Color.appDefaultColor ,clipsToBounds: false)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard !textField.hasError() else { return }
        textfield.makeBorder(0, color: Constants.Color.appDefaultColor ,clipsToBounds: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          self.resignFirstResponder()
          actionKeyboardReturn?()
          return true
       }
}
