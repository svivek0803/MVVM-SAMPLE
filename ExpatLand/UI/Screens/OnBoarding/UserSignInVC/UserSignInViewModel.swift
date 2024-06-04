//
//  UserSignInViewModel.swift
//  ExpatLand
//
//  Created by User on 02/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation

final class UserSignInViewModel {
    
    // MARK: - INPUT
    private let repository: ExpatLandRepositoryHandling
    
    // MARK: - OUTPUT
    var response: Observable<Result<UserTokenModel>?> = Observable(nil)
    var responseVerifyEmail: Observable<Result<RegistrationResponseModel>?> = Observable(nil)
    
    
    init(withRepositoryHandling repository: ExpatLandRepositoryHandling = ExpatLandRepository()
        ) {
            self.repository = repository
           
        }
    
    
    func verifyEmail(token:String)
    {
        LoadingOverlay.shared.showOverlay()
        repository.verifyEmail(parameters: nil,path:token) { (result) in
            LoadingOverlay.shared.hideOverlayView()
            self.responseVerifyEmail.value = result
        }
    }
    
    func didTapLogin(email: String , password:String) {
        
        LoadingOverlay.shared.showOverlay()
        repository.signIn(parameters: [ServerKeys.email: email , ServerKeys.password: password]) { (result) in
            LoadingOverlay.shared.hideOverlayView()
            self.response.value = result
        }
    }
    
    func getProfile(){
        
        self.repository.getProfileData(completion: { (result) in
            
            switch result
            {
            
            case .success(value: let value):
                Constants.userDefaults.setValue(value.notificationStatus, forKey: UserDefaultKeys.notificationStatus)
            case .failure(error: let error):
                Console.log(error)
            }
        })
    }
}

