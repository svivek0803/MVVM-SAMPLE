//
//  CustomTextFieldView.swift
//  ExpatLand
//
//  Created by User on 07/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import UIKit

class CustomTextFieldView: UIView {
    
    // MARK: PROPERTIES -
    
    let errorLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = Validation.errorEmptyTextFeild
        l.isHidden = true
        l.font = UIFont.kAppDefaultFontRegular(ofSize: 12)
        l.textColor = Constants.Color.appDefaultErrorColor
        l.numberOfLines = 0
        return l
    }()
    
    let textfield: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.addShadow(radius: 4, cornerRadius: 2, color: Constants.Color.appDefaultColor)
        tf.textColor = Constants.Color.appBaseBalticColor
        tf.font = UIFont.kAppDefaultFontRegular(ofSize: 14)
        tf.tintColor = Constants.Color.appBaseBalticColor
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
        textfield.delegate = self
    }
    
    func setUpConstraints(){
        stackView.pin(to: self)
        textfield.heightAnchor.constraint(equalToConstant: 53).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
}

extension CustomTextFieldView {
    
    func setLeftView(imageName : String)
    {
        textfield.setLeftViewImage(img: UIImage(named: imageName)!)
    }
    
    func showError(error: String)
    {
        textfield.makeBorder(1, color: Constants.Color.appDefaultErrorColor ,clipsToBounds: false)
        errorLabel.text = error
        errorLabel.isHidden = false
    }
    
    func hideError()
    {
        textfield.makeBorder(0, color: Constants.Color.appDefaultErrorColor ,clipsToBounds: false)
        errorLabel.isHidden = true
    }
    
    func validate()->Bool
    {
        if textfield.text?.trimFromLeading().isEmpty ?? false
        {
            showError(error: Validation.errorEmptyTextFeild)
            return false
        }
        
        hideError()
        return true
    }
    
    func validateSecondaryEmail()->Bool
    {
        guard !(textfield.text?.trimFromLeading().isEmpty ?? false) else {
            return true
        }
        
        if !(textfield.text?.isValidEmail() ?? false)
        {
            showError(error: Validation.errorEmailInvalid)
            return false
        }
        
        hideError()
        return true
    }
}

//MARK:UITextFeildDelegate
//==============
extension CustomTextFieldView: UITextFieldDelegate {
    
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
