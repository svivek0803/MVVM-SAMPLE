//
//  ForgotPasswordVC.swift
//  ExpatLand
//
//  Created by User on 04/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import UIKit

//MARK:ForgotPasswordVC
//=====================
class ForgotPasswordVC: UIViewController {

    //MARK:IBOutlets
    //==============
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var imgLogo : UIImageView!
    @IBOutlet weak var viewFooter : UIView!
    @IBOutlet weak var stackView : UIStackView!
    @IBOutlet weak var viewEmail : EmailView!
    @IBOutlet weak var btnSignIn : UIButton!
    @IBOutlet weak var btnResetLink : UIButton!
    @IBOutlet weak var btnBack : UIButton!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblNote : UILabel!

    
    
    //MARK:Variables
    //==============
    private var viewModel: ForgotPasswordViewModel!
    
    
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
extension ForgotPasswordVC {
   
    private func initialSetup(){
        viewFooter.backgroundColor = Constants.Color.appDefaultColor
        btnResetLink.backgroundColor = Constants.Color.appDefaultColor
        btnResetLink.setTitle(Constants.TextConstant.requestResetLink, for: .normal)
        btnResetLink.setTitleColor(.white, for: .normal)
        btnResetLink.makeRoundCorner(2)
        btnSignIn.setTitle(Constants.TextConstant.backToSignIn, for: .normal)
        btnSignIn.setTitleColor(Constants.Color.appDefaultColor, for: .normal)
        lblTitle.text = Constants.TextConstant.forgotPassword
        lblTitle.textColor = Constants.Color.appDefaultColor
        viewEmail.actionKeyboardReturn = { [weak self] in
            self?.viewEmail.textfield.resignFirstResponder()
        }
        
        self.dismissKey()
    }
    
    func setupViewModel()
    {
        viewModel = ForgotPasswordViewModel()
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: ForgotPasswordViewModel)
    {
        viewModel.credentialsInputErrorMessage.observe(on: self){ [weak self] error in
            guard  error != "" else { return }
            self?.viewEmail.showError(error: error)
        }
        subscribeResponseObserver()
    }
    
    private func subscribeResponseObserver()
    {
        viewModel.response.observe(on: self) { [weak self] (result) in
            guard  result != nil else { return }
            switch result {
            case .success( _):
                let vc = CheckEmailVC.instantiate(fromAppStoryboard: .onboarding)
                vc.emailText = self?.viewEmail.textfield.text ?? ""
                self?.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                self?.handleError(error: error)
            case .none:
                Console.log("none")
            }
        }
    }
    
    private func handleError(error: Error) {
        guard let httpRequestError = error as? NetworkError else {
            showAlert(message: error.localizedDescription)
            return
        }
        
        switch httpRequestError {
            case .validationError:
               showAlert(message: Constants.AlertMessage.localizedString(.accountNotFoundWithSuchEmail))
            case .unauthorize:
               showAlert(message: Constants.AlertMessage.localizedString(.registerationPending))
            case .emailVerificationPending:
                showAlert(message: Constants.AlertMessage.localizedString(.pleaseVerifyEmail))
            default:
                showAlert(message: error.localizedDescription)
        }
    }
    
    private func toggleBorder(_ textField: UITextField)
    {
        guard textField.text != "" else {
            viewEmail.textfield.makeBorder(0, color: Constants.Color.appDefaultColor,clipsToBounds: false)
            return }
        viewEmail.hideError()
        viewEmail.textfield.makeBorder(1, color: Constants.Color.appDefaultColor,clipsToBounds: false)
      
    }
    
}
//MARK:IBActions
//==============
extension ForgotPasswordVC {
   
    @IBAction func _buttonBack(_ sender : UIButton){
        Console.log("_buttonBack")
        self.popViewController()
    }
    @IBAction func _buttonSignIn(_ sender : UIButton){
        Console.log("_buttonSignIn")
        let vc = UserSignInVC.instantiate(fromAppStoryboard: .onboarding)
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func _buttonResetLink(_ sender : UIButton){
        Console.log("_buttonResetLink")
        let emailValidation = viewEmail.validate()
        guard emailValidation  else { return}
        
        viewModel.didTapForgotPassword(email: viewEmail.textfield.text ?? "")
        
    }
  
}

