//
//  UserSignInVC.swift
//  ExpatLand
//
//  Created by User on 02/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import UIKit

//MARK:UserSignInVC
//================
class UserSignInVC: UIViewController {

    //MARK:IBOutlets
    //==============
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var imgLogo : UIImageView!
    @IBOutlet weak var viewFooter : UIView!
    @IBOutlet weak var stackView : UIStackView!
    @IBOutlet weak var viewEmail : EmailView!
    @IBOutlet weak var viewPassword : PasswordView!
    @IBOutlet weak var btnSignIn : UIButton!
    @IBOutlet weak var btnRegister : UIButton!
    @IBOutlet weak var btnBack : UIButton!
    @IBOutlet weak var btnForgotPasswd : UIButton!
    @IBOutlet weak var lblTitle : UILabel!

    
    
    //MARK:Variables
    //==============
    private var viewModel: UserSignInViewModel!
    var token = String()
    
    
    //MARK:Life - Cycle
    //=================
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        self.setupViewModel()
    }


}
//MARK:Functions
//==============
extension UserSignInVC {
   
    private func initialSetup(){
        viewFooter.backgroundColor = Constants.Color.appDefaultColor
        btnSignIn.backgroundColor = Constants.Color.appDefaultColor
        btnSignIn.setTitleColor(.white, for: .normal)
        btnSignIn.makeRoundCorner(2)
        btnRegister.setTitleColor(Constants.Color.appDefaultColor, for: .normal)
        lblTitle.textColor = Constants.Color.appDefaultColor
        viewEmail.textfield.returnKeyType = .next
        viewPassword.textfield.returnKeyType = .done
        textfieldOperationsForKeyboard()
       self.dismissKey()
    }
    
   
    
    func setupViewModel()
    {
        viewModel = UserSignInViewModel()
        subscribeResponseObserver()
        subscribeVerifyEmailObserver()
        checkForEmailToken()
    }
    
    
    func textfieldOperationsForKeyboard()
    {
        viewEmail.actionKeyboardReturn = { [weak self] in
            self?.viewPassword.textfield.becomeFirstResponder()
        }
        viewPassword.actionKeyboardReturn = { [weak self] in
            self?.viewPassword.textfield.resignFirstResponder()
        }
    }
    

    
    private func subscribeResponseObserver()
    {
        viewModel.response.observe(on: self) { [weak self] (result) in
            guard  result != nil else { return }
            switch result {
            case .success(let data):
                self?.handleSuccess(data: data)
            case .failure(let error):
                self?.handleError(error: error)
            case .none:
                Console.log("none")
            }
        }
    }
    
    private func subscribeVerifyEmailObserver()
    {
        viewModel.responseVerifyEmail.observe(on: self) { [weak self] (result) in
            guard  result != nil else { return }
            switch result {
            case .success(_):
                self?.showAlert(message: Constants.AlertMessage.localizedString(.emailVerifySuccess))
            case .failure(_):
                self?.showAlert(message: Constants.AlertMessage.localizedString(.emailVerifyError))
            case .none:
                Console.log("none")
            }
        }
    }
    
    
    func checkForEmailToken()
    {
        guard token != "" else { return}
        viewModel.verifyEmail(token: token)
    }
    
    
    private func handleSuccess(data: UserTokenModel)
    {
    
        if data.defaultPassword == 1
        {
            let vc = ResetPasswordVC.instantiate(fromAppStoryboard: .onboarding)
            vc.navigationType = .defaultPassword
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            viewModel.getProfile()
            Constants.userDefaults.setValue(true, forKey: UserDefaultKeys.isLoggedIn)
            let vc = MainTabBarController.instantiate(fromAppStoryboard: .dashboard)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func handleError(error: Error) {
        guard let httpRequestError = error as? NetworkError else {
            showAlert(message: error.localizedDescription)
            return
        }
        
        switch httpRequestError {
            case .validationError:
               showAlert(message: Constants.AlertMessage.localizedString(.emailOrPasswordIncorrect))
            case .unauthorize:
               showAlert(message: Constants.AlertMessage.localizedString(.registerationPending))
            case .emailVerificationPending:
                showAlert(message: Constants.AlertMessage.localizedString(.pleaseVerifyEmail))
            default:
                showAlert(message: error.localizedDescription)
        }
    }
    
    
}
//MARK:IBActions
//==============
extension UserSignInVC {
   
    @IBAction func _buttonBack(_ sender : UIButton){
        Console.log("_buttonBack")
        self.popViewController()
    }
    @IBAction func _buttonSignIn(_ sender : UIButton){
        let emailValidation = viewEmail.validateEmptyFeild()
        let passwordValidation = viewPassword.validateWithoutCountCheck()
        
        guard emailValidation , passwordValidation else { return}
        viewModel.didTapLogin(email: viewEmail.textfield.text!, password: viewPassword.textfield.text!)
    }
    @IBAction func _buttonRegister(_ sender : UIButton){
        Console.log("_buttonRegister")
        let vc = UserRegistrationVC.instantiate(fromAppStoryboard: .onboarding)
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func _buttonForgotPassword(_ sender : UIButton){
        Console.log("_buttonForgotPassword")
        let vc = ForgotPasswordVC.instantiate(fromAppStoryboard: .onboarding)
        navigationController?.pushViewController(vc, animated: true)
    }
}

