//
//  ForgotPasswordViewModel.swift
//  ExpatLand
//
//  Created by User on 13/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation

final class ForgotPasswordViewModel {
    
    // MARK: - INPUT
    private let repository: ExpatLandRepositoryHandling
    
    // MARK: - OUTPUT
    var response: Observable<Result<RegistrationResponseModel>?> = Observable(nil)
    var credentialsInputErrorMessage = Observable("")
    
    
    init(withRepositoryHandling repository: ExpatLandRepositoryHandling = ExpatLandRepository()
        ) {
            self.repository = repository
           
        }
    
    
    func didTapForgotPassword(email: String ) {
        
        LoadingOverlay.shared.showOverlay()
        repository.forgotPassword(parameters: [ServerKeys.email: email]) { (result) in
            LoadingOverlay.shared.hideOverlayView()
            self.response.value = result
        }
    }

    func validateCredentialsInput(email: String) -> Bool {
        
        if email.isEmpty {
            credentialsInputErrorMessage.value = Validation.errorEmptyTextFeild
            return false
        }
        else if !email.isValidEmail()
        {
            credentialsInputErrorMessage.value = Validation.errorEmailInvalid
            return false
        }

        return true
    }
    
    
}
