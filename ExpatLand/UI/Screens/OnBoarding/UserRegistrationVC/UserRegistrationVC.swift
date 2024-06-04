//
//  UserRegistrationVC.swift
//  ExpatLand
//
//  Created by User on 04/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import UIKit


//MARK:UserRegistrationVC
//=======================
class UserRegistrationVC: UIViewController {

    
    //MARK:IBOutlets
    //==============
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var imgLogo : UIImageView!
    @IBOutlet weak var viewFooter : UIView!
    @IBOutlet weak var stackView : UIStackView!
    @IBOutlet weak var viewEmail : EmailView!
    @IBOutlet weak var viewPassword : PasswordView!
    @IBOutlet weak var viewFirstName : CustomTextFieldView!
    @IBOutlet weak var viewLastName : CustomTextFieldView!
    @IBOutlet weak var viewCompany : CustomTextFieldView!
    @IBOutlet weak var viewCountry : DropDownView!
    @IBOutlet weak var viewCity : DropDownView!
    @IBOutlet weak var viewExpertiseArea : DropDownView!
    @IBOutlet weak var viewSecondaryEmail : CustomTextFieldView!
    @IBOutlet weak var btnSignIn : UIButton!
    @IBOutlet weak var btnRegister : UIButton!
    @IBOutlet weak var btnBack : UIButton!
    @IBOutlet weak var btnForgotPasswd : UIButton!
    @IBOutlet weak var btnCheckBox : UIButton!
    @IBOutlet weak var btnTermsConds : UIButton!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblAgreeTerms : UILabel!

    
    
    //MARK:Variables
    //==============
    private var viewModel: UserRegistrationViewModel!
    
    
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
extension UserRegistrationVC {
   
    private func initialSetup(){
        viewFooter.backgroundColor = Constants.Color.appDefaultColor
        btnRegister.backgroundColor = Constants.Color.appDefaultColor
        btnRegister.setTitle(Constants.TextConstant.register, for: .normal)
        btnRegister.setTitleColor(.white, for: .normal)
        btnRegister.makeRoundCorner(2)
        btnSignIn.setTitle(Constants.TextConstant.signIn, for: .normal)
        btnSignIn.setTitleColor(Constants.Color.appDefaultColor, for: .normal)
        lblTitle.text = Constants.TextConstant.registration.uppercased()
        lblTitle.textColor = Constants.Color.appDefaultColor
        viewFirstName.textfield.placeholder = Constants.TextConstant.name
        viewLastName.textfield.placeholder = Constants.TextConstant.lastName
        viewCompany.textfield.placeholder = Constants.TextConstant.company
        [viewFirstName,viewLastName,viewCompany].forEach{
            $0?.textfield.keyboardType = .namePhonePad
            $0?.textfield.maxLength = 30
        }
        viewSecondaryEmail.textfield.placeholder = Constants.TextConstant.secondaryEmail
        viewSecondaryEmail.textfield.keyboardType = .emailAddress
        lblAgreeTerms.textColor = Constants.Color.appDefaultErrorColor
        lblAgreeTerms.isHidden = true
        self.btnCheckBox.setImage(UIImage(named: "unChecked"), for: .normal)
        btnCheckBox.isSelected = false
        btnCheckBox.imageView?.tintColor = Constants.Color.appDefaultColor
        btnTermsConds.setTitleColor(Constants.Color.appDefaultColor, for: .normal)
        viewCountry.textfield.placeholder = Constants.TextConstant.country
        viewCountry.dropDownViewDataSetProtocol = self
        viewCity.dropDownViewDataSetProtocol = self
        viewExpertiseArea.dropDownViewDataSetProtocol = self
        viewCity.textfield.placeholder = Constants.TextConstant.city
        viewCity.isEnabled(enable: false)
        viewExpertiseArea.textfield.placeholder = Constants.TextConstant.expertise
        textfieldOperationsForKeyboard()
        self.dismissKey()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.viewCity.setUpDropDown(childView: self.viewCity, view: self.scrollView)
        }
       
    }
    
    func setupViewModel()
    {
        viewModel = UserRegistrationViewModel()
        subscribeCitiesObservers()
        subscribeCountriesObservers()
        subscribeExpertiseObserver()
        subscribeRegisterResponseObserver()
        viewModel.getCountries()
        viewModel.getExpertise()
    }
    
    func subscribeCitiesObservers()
    {
        viewModel.responseCities.observe(on: self) { [weak self] (result) in
            guard  result != nil else { return }
            switch result {
            case .success(let data):
                self?.viewCity.data = data.map {
                    Element(id: $0.id ?? 0 ,name: $0.name ?? "", selected: false)
                }
                self!.viewCity.dropDown.refresh()
            case .failure(let error):
                Console.log(error.localizedDescription)
            case .none:
                Console.log("none")
            }
        }
    }
    
    func subscribeCountriesObservers()
    {
        viewModel.responseCountries.observe(on: self) { [weak self] (result) in
            guard  result != nil else { return }
            switch result {
            case .success(let data):
                guard data.count > 0 else { return }
                self?.viewCountry.data = data.map {
                    Element(id: $0.id ?? 0 ,name: $0.name ?? "", selected: false)
                }
                self!.viewCountry.setUpDropDown(childView: self!.viewCountry, view: self!.scrollView)
            case .failure(let error):
                Console.log(error.localizedDescription)
            case .none:
                Console.log("none")
            }
        }
    }
    
    func subscribeExpertiseObserver()
    {
        viewModel.responseExpertise.observe(on: self) { [weak self] (result) in
            guard  result != nil else { return }
            switch result {
            case .success(let data):
                guard data.count > 0 else { return }
                self?.viewExpertiseArea.data = data.map {
                    Element(id: $0.id ?? 0 ,name: $0.name ?? "", selected: false)
                }
                self!.viewExpertiseArea.setUpDropDown(childView: self!.viewExpertiseArea, view: self!.scrollView)
            case .failure(let error):
                Console.log(error.localizedDescription)
            case .none:
                Console.log("none")
            }
        }
    }
    
    func subscribeRegisterResponseObserver()
    {
        viewModel.responseRegister.observe(on: self) { [weak self] (result) in
            guard  result != nil else { return }
            switch result {
            case .success(let data):
                self?.handleSuccess(data:data)
            case .failure(let error):
                self?.handleError(error: error)
            case .none:
                Console.log("none")
            }
        }
    }
    
    private func handleError(error: Error) {
        
       uncheckAgreement()
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
    
    private func handleSuccess(data:RegistrationResponseModel)
    {
        if data.errors != nil {
            if  data.errors?.email != nil {
                uncheckAgreement()
            showAlert(message: data.errors?.email?.first ?? Constants.AlertMessage.localizedString(.generalError))
            }
            else {
                uncheckAgreement()
                showAlert(message: data.errors?.secondaryEmail?.first ?? Constants.AlertMessage.localizedString(.generalError))
            }
        }
        else {
            if data.whitelisting ?? false
            {
                showAlert(message: Constants.AlertMessage.localizedString(.verificationLinkWasSent), title: Constants.AlertMessage.localizedString(.success)) {
                    self.popViewController()
                }
            }
            else {
                showAlert(message: Constants.AlertMessage.localizedString(.notWhiteListed), title: Constants.AlertMessage.localizedString(.success)) {
                    self.popViewController()
                }
            }
        }
        
    }
    

    
    func validate()->Bool
    {
        let emailValidation = viewEmail.validate()
        let passwordValidation = viewPassword.validate()
        let firstNameVaidation = viewFirstName.validate()
        let lastNameValidation = viewLastName.validate()
        let companyValidation = viewCompany.validate()
        let countryValidation = viewCountry.validate()
        let cityValidation = viewCity.validate()
        let expertiseValidation = viewExpertiseArea.validate()
        let agreement = validateAgreementBox(selected: btnCheckBox.isSelected)
        let secondaryMailValidation = viewSecondaryEmail.validateSecondaryEmail()
        guard emailValidation , passwordValidation,firstNameVaidation,lastNameValidation,companyValidation,countryValidation,cityValidation,expertiseValidation , agreement , secondaryMailValidation else { return false }
        return true
    }
    
    func   validateAgreementBox(selected: Bool) -> Bool
    {
            lblAgreeTerms.isHidden = selected
            return selected
    }
    
   
    
    
    func setupDropDowns()
    {
        closeAllDropDowns()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.viewCountry.setUpDropDown(childView: self.viewCountry, view: self.scrollView)
            self.viewCity.setUpDropDown(childView: self.viewCity, view: self.scrollView)
            self.viewExpertiseArea.setUpDropDown(childView: self.viewExpertiseArea, view: self.scrollView)
        }
    }
    
    private func uncheckAgreement()
    {
        self.btnCheckBox.setImage(UIImage(named: "unChecked"), for: .normal)
        self.btnCheckBox.isSelected = false
    }
    
    private func closeAllDropDowns()
    {
        viewCountry.hideDropDown()
        viewCity.hideDropDown()
        viewExpertiseArea.hideDropDown()
    }
    
    func textfieldOperationsForKeyboard()
    {
        viewEmail.textfield.returnKeyType = .next
        viewPassword.textfield.returnKeyType = .next
        viewFirstName.textfield.returnKeyType = .next
        viewLastName.textfield.returnKeyType = .next
        viewCompany.textfield.returnKeyType = .done
        viewSecondaryEmail.textfield.returnKeyType = .done
        
        viewEmail.actionKeyboardReturn = { [weak self] in
            self?.viewPassword.textfield.becomeFirstResponder()
        }
        
        viewPassword.actionKeyboardReturn = { [weak self] in
            self?.viewFirstName.textfield.becomeFirstResponder()
        }
        
        viewFirstName.actionKeyboardReturn = { [weak self] in
            self?.viewLastName.textfield.becomeFirstResponder()
        }
        
        viewLastName.actionKeyboardReturn = { [weak self] in
            self?.viewCompany.textfield.becomeFirstResponder()
        }
        
        viewCompany.actionKeyboardReturn = { [weak self] in
            self?.viewCompany.textfield.resignFirstResponder()
        }
        
        viewSecondaryEmail.actionKeyboardReturn = { [weak self] in
            self?.viewSecondaryEmail.textfield.resignFirstResponder()
        }
    }
 
}
//MARK:IBActions
//==============
extension UserRegistrationVC {
   
    @IBAction func _buttonBack(_ sender : UIButton){
        Console.log("_buttonBack")
        self.popViewController()
    }
    @IBAction func _buttonSignIn(_ sender : UIButton){
        Console.log("_buttonSignIn")
        let vc = UserSignInVC.instantiate(fromAppStoryboard: .onboarding)
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func _buttonRegister(_ sender : UIButton){
        Console.log("_buttonRegister")
        
        setupDropDowns()
        if validate() {
            viewModel.updateRegistrationModel(email: viewEmail.textfield.text ?? "", password: viewPassword.textfield.text ?? "", name: viewFirstName.textfield.text ?? "", lastName: viewLastName.textfield.text ?? "", company: viewCompany.textfield.text ?? "", country: viewCountry.textfield.text ?? "", cityIDS: viewCity.data.filter{$0.selected}.map{$0.id} , expertiseIDS: viewExpertiseArea.data.filter{$0.selected}.map{$0.id}, secondaryEmail: viewSecondaryEmail.textfield.text ?? "", agreement: btnCheckBox.isSelected)
        }
        else
        {
            self.btnCheckBox.setImage(UIImage(named: "unChecked"), for: .normal)
            self.btnCheckBox.isSelected = false
        }
        
    
    }
    @IBAction func _buttonCheckBox(_ sender : UIButton){
        Console.log("_buttonCheckBox")
        
        if !sender.isSelected  {
            btnCheckBox.setImage(UIImage(named: "checked"), for: .normal)
            sender.isSelected = true
            lblAgreeTerms.isHidden = true
           
        }else {
            self.btnCheckBox.setImage(UIImage(named: "unChecked"), for: .normal)
            sender.isSelected = false
            

        }
    }
    @IBAction func _buttonTermsConditions(_ sender : UIButton){
        Console.log("_buttonTermsConditions")
        let vc = UIStoryboard.init(name: "OnBoarding", bundle: nil).instantiateViewController(withIdentifier: "TermsConditionsVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK:DropDownViewDataSetProtocol
//========================
extension UserRegistrationVC : DropDownViewDataSetProtocol {
    func hideExistingDropDowns(view: DropDownView) {
     
        if view == viewCountry
        {
            viewCity.hideDropDown()
            viewExpertiseArea.hideDropDown()
        }
        else if view == viewCity
        {
            viewCountry.hideDropDown()
            viewExpertiseArea.hideDropDown()
        }
        else if view == viewExpertiseArea
        {
            viewCity.hideDropDown()
            viewCountry.hideDropDown()
        }
    }
    
    func fetchItemIds(ids: [Int] , view: DropDownView ) {
      
        guard view == viewCountry else { return}
        guard ids.count > 0  else {
            viewCity.isEnabled(enable: false)
            viewCity.textfield.text = ""
            return
        }
        viewModel.getCities(data: ids)
        viewCity.isEnabled(enable: true)
        viewCity.textfield.text = ""
    }
    
    
}


