//
//  UserRegistrationViewModel.swift
//  ExpatLand
//
//  Created by User on 04/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation

final class UserRegistrationViewModel {
    // MARK: - INPUT
    private let repository: ExpatLandRepositoryHandling
    
    // MARK: - OUTPUT
    var responseCities: Observable<Result<[CityModel]>?> = Observable(nil)
    var responseCountries: Observable<Result<[CountryModel]>?> = Observable(nil)
    var responseExpertise: Observable<Result<[ExpertiseModel]>?> = Observable(nil)
    var responseRegister: Observable<Result<RegistrationResponseModel>?> = Observable(nil)
    private var registrationModel = RegistrationModel()

    
    init(withRepositoryHandling repository: ExpatLandRepositoryHandling = ExpatLandRepository()
        ) {
            self.repository = repository
           
        }
    
    func getCities(data: [Int])
    {
       
        self.repository.getCities(parameters: data.indexedDictionary) { (result) in
            self.responseCities.value = result
        }
    }
    
    func getCountries()
    {
        self.repository.getCountries() { (result) in
            self.responseCountries.value = result
        }
    }
    
    func getExpertise()
    {
        self.repository.getExpertise() { (result) in
            self.responseExpertise.value = result
        }
    }
    
    func register()
    {
        LoadingOverlay.shared.showOverlay()
        self.repository.register(model: registrationModel) { (result) in
            print(result)
            self.responseRegister.value = result
            LoadingOverlay.shared.hideOverlayView()
        }
    }
    
    func updateRegistrationModel(email:String,password:String,name:String,lastName:String,company:String,country:String,cityIDS:[Int],expertiseIDS:[Int],secondaryEmail:String,agreement:Bool) {
        self.registrationModel.email = email
        self.registrationModel.password = password
        self.registrationModel.firstName = name
        self.registrationModel.lastName = lastName
        self.registrationModel.company = company
        self.registrationModel.secondaryEmail = secondaryEmail
        self.registrationModel.cityIDS = cityIDS
        self.registrationModel.expertiseIDS = expertiseIDS
        register()
        }
    
   
}
