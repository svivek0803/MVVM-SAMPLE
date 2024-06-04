//
//  ResetPasswordViewModel.swift
//  ExpatLand
//
//  Created by User on 13/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation

final class ResetPasswordViewModel {
    
    // MARK: - INPUT
    private let repository: ExpatLandRepositoryHandling
    
    // MARK: - OUTPUT
    var response: Observable<Result<RegistrationResponseModel>?> = Observable(nil)
    var inputErrorMessage: Observable<[ValidationModel]> = Observable([])
    
    
    init(withRepositoryHandling repository: ExpatLandRepositoryHandling = ExpatLandRepository()
        ) {
            self.repository = repository
           
        }
    
    
    func didTapResetPassword(token:String,password: String ) {
        
        LoadingOverlay.shared.showOverlay()
        repository.resetPassword(parameters: [ServerKeys.token:token,ServerKeys.password: password]) { (result) in
            LoadingOverlay.shared.hideOverlayView()
            self.response.value = result
        }
    }
    
    
    func requestDefaultPassword(password:String)
    {
        LoadingOverlay.shared.showOverlay()
        repository.requestDefaultPassword(parameters: [ServerKeys.password: password]) { (result) in
            LoadingOverlay.shared.hideOverlayView()
            self.response.value = result
        }
    }

    func validateCredentialsInput(newPassword: String,confirmPassword: String) -> Bool {
        
        var validationArr : [ValidationModel] = []
        
        if newPassword.isEmpty {
            
            validationArr.append(ValidationModel(fieldType: ValidationError.newPassword , errorString: Validation.errorEmptyTextFeild))
        }
        else if  newPassword.count < 6 {
            
            validationArr.append(ValidationModel(fieldType: ValidationError.newPassword , errorString: Validation.errorPasswordLengthInvalid))
        }
        
        if confirmPassword.isEmpty {
            validationArr.append(ValidationModel(fieldType: ValidationError.confirmPassword , errorString: Validation.errorEmptyTextFeild))
        }
        else if confirmPassword.count < 6
        {
            validationArr.append(ValidationModel(fieldType: ValidationError.confirmPassword , errorString: Validation.errorPasswordLengthInvalid))
        }
        
        guard  validationArr.count <= 0 else   {
            inputErrorMessage.value = validationArr
            return false }
        
        if confirmPassword != newPassword
        {
            validationArr.append(ValidationModel(fieldType: ValidationError.passwordMismatch , errorString: Validation.errorPasswordMismatch))
            inputErrorMessage.value = validationArr
            return false
        }
        
        
        return true
    }
    
    
}
