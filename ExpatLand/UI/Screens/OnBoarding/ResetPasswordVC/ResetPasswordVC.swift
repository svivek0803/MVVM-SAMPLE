//
//  ResetPasswordVC.swift
//  ExpatLand
//
//  Created by User on 04/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import UIKit


enum ResetPassWordNavigationType
{
    case defaultPassword
    case deepLink
}

//MARK:ResetPasswordVC
//====================
class ResetPasswordVC: UIViewController {

    //MARK:IBOutlets
    //==============
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var imgLogo : UIImageView!
    @IBOutlet weak var viewFooter : UIView!
    @IBOutlet weak var stackView : UIStackView!
    @IBOutlet weak var newPasswordView : PasswordView!
    @IBOutlet weak var confirmPasswordView : PasswordView!
    @IBOutlet weak var btnSignIn : UIButton!
    @IBOutlet weak var btnResetPassword : UIButton!
    @IBOutlet weak var btnBack : UIButton!
    @IBOutlet weak var lblTitle : CustomRegularLabel!
    @IBOutlet weak var lblNote : CustomRegularLabel!

    
    
    //MARK:Variables
    //==============
    var token = String()
    private var viewModel: ResetPasswordViewModel!
    var navigationType: ResetPassWordNavigationType = .deepLink
    
    //MARK:Life - Cycle
    //=================
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        self.setupViewModel()
        // Do any additional setup after loading the view.
    }


}
//MARK:Functions
//==============
extension ResetPasswordVC {
   
    private func initialSetup(){
        viewFooter.backgroundColor = Constants.Color.appDefaultColor
        btnResetPassword.backgroundColor = Constants.Color.appDefaultColor
        btnResetPassword.setTitle(Constants.TextConstant.resetPassword, for: .normal)
        btnResetPassword.setTitleColor(.white, for: .normal)
        btnResetPassword.makeRoundCorner(2)
        btnSignIn.setTitle(Constants.TextConstant.backToSignIn, for: .normal)
        btnSignIn.setTitleColor(Constants.Color.appDefaultColor, for: .normal)
        lblTitle.text = Constants.TextConstant.resetPASSWORD
        lblTitle.textColor = Constants.Color.appDefaultColor
        newPasswordView.textfield.placeholder = Constants.TextConstant.newPassword
        confirmPasswordView.textfield.placeholder = Constants.TextConstant.repeatNewPassword
        confirmPasswordView.textfield.setLeftViewImage(img: UIImage(named: "confirmPassword")!)
        newPasswordView.textfield.returnKeyType = .next
        confirmPasswordView.textfield.returnKeyType = .done
        textfieldOperationsForKeyboard()
        self.dismissKey()
        
        switch navigationType {
        case .deepLink:
            lblNote.text = Constants.TextConstant.resetPasswordNote
        case .defaultPassword:
            btnSignIn.isHidden = false
            lblNote.text = Constants.TextConstant.newPasswordNote
        }
        
    }
    
    func setupViewModel()
    {
        viewModel = ResetPasswordViewModel()
        subscribeForValidationErrors()
        subscribeResponseObserver()
    }
    
    func subscribeForValidationErrors()
    {
        viewModel.inputErrorMessage.observe(on: self) { [weak self] validations in
            guard  validations.count > 0 else { return }
            
            validations.forEach{
                switch $0.fieldType
                {
                case .newPassword:
                    self?.newPasswordView.showError(error: $0.errorString )
                case .confirmPassword:
                    self?.confirmPasswordView.showConfirmPasswordError(error: $0.errorString)
                case .passwordMismatch:
                    self?.newPasswordView.showError()
                    self?.confirmPasswordView.showConfirmPasswordError(error: $0.errorString)
                default:
                    Console.log("none")
                }
            }
        }
    }
    
    
    private func subscribeResponseObserver()
    {
        viewModel.response.observe(on: self) { [weak self] (result) in
            guard  result != nil else { return }
            switch result {
            case .success( _):
                self?.showSuccessAlert()
            case .failure(let error):
                self?.handleError(error: error)
            case .none:
                Console.log("none")
            }
        }
    }
    
    private func showSuccessAlert()
    {
        showAlert(message: Constants.AlertMessage.localizedString(.resetPasswordSuccess), title: Constants.AlertMessage.localizedString(.success)) {
            let vc = UserSignInVC.instantiate(fromAppStoryboard: .onboarding)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func handleError(error: Error) {
        guard let httpRequestError = error as? NetworkError else {
            showAlert(message: error.localizedDescription)
            return
        }
        
        switch httpRequestError {
            case .requestForbidden:
               showAlert(message: Constants.AlertMessage.localizedString(.resetPasswordLinkExpired))
            default:
                showAlert(message: error.localizedDescription)
        }
    }
    
    
    private func validate()->Bool
    {
        let newPassWordValidation = newPasswordView.validate()
        let repeatPassWordValidation = confirmPasswordView.validate()
        guard newPassWordValidation , repeatPassWordValidation else { return false }
        
        guard newPasswordView.textfield.text == confirmPasswordView.textfield.text
        
       else  {
            confirmPasswordView.showConfirmPasswordError(error: Validation.errorPasswordMismatch)
            return false
        }
        return true
    }
    
    func textfieldOperationsForKeyboard()
    {
        newPasswordView.actionKeyboardReturn = { [weak self] in
            self?.confirmPasswordView.textfield.becomeFirstResponder()
        }
        confirmPasswordView.actionKeyboardReturn = { [weak self] in
            self?.confirmPasswordView.textfield.resignFirstResponder()
        }
    }
    
}
//MARK:IBActions
//==============
extension ResetPasswordVC {
   
    @IBAction func _buttonBack(_ sender : UIButton){
        Console.log("_buttonBack")
        self.popViewController()

    }
    @IBAction func _buttonSignIn(_ sender : UIButton){
        Console.log("_buttonSignIn")
        let vc = UserSignInVC.instantiate(fromAppStoryboard: .onboarding)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func _buttonResetPassword(_ sender : UIButton){
        Console.log("_buttonResetPassword")
        if  validate()
        {
            
            switch navigationType {
            case .deepLink:
                viewModel.didTapResetPassword(token: token, password: newPasswordView.textfield.text ?? "")
            case .defaultPassword:
                viewModel.requestDefaultPassword(password: newPasswordView.textfield.text ?? "")
            }
            
            
        }
    }
    
}


