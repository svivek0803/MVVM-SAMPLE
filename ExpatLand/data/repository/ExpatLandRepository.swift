//
//  ExpatLandRepository.swift
//  ExpatLand
//
//  Created by User on 03/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import PromiseKit

protocol ExpatLandRepositoryHandling: AnyObject {
   
    func signIn(parameters: [String : Any]? ,completion: @escaping (Result<UserTokenModel>) -> Void)
    func getCities(parameters:[ String: Any]?,completion: @escaping (Result<[CityModel]>) -> Void)
    func getCountries(completion: @escaping (Result<[CountryModel]>) -> Void)
    func getExpertise(completion: @escaping (Result<[ExpertiseModel]>) -> Void)
    func getMemberships(completion: @escaping (Result<UserModel>) -> Void)
    func register(model:RegistrationModel,completion: @escaping (Result<RegistrationResponseModel>) -> Void)
    func forgotPassword(parameters: [String : Any]?,completion: @escaping (Result<RegistrationResponseModel>) -> Void)
    func resetPassword(parameters:[ String: Any]? ,completion: @escaping (Result<RegistrationResponseModel>) -> Void)
    func requestDefaultPassword(parameters:[ String: Any]? ,completion: @escaping (Result<RegistrationResponseModel>) -> Void)
    func verifyEmail(parameters:[ String: Any]? ,path:String,completion: @escaping (Result<RegistrationResponseModel>) -> Void)
    func requestFiltering(parameters:[ String: Any]? ,completion: @escaping (Result<[FilteringModel]>) -> Void)
    func requestRegions(parameters:[ String: Any]? ,completion: @escaping (Result<[RegionModel]>) -> Void)
    func filterCountries(parameters:[ String: Any]? ,completion: @escaping (Result<[CountryModel]>) -> Void)
    func filterCities(parameters:[ String: Any]? ,completion: @escaping (Result<[CityModel]>) -> Void)
    func filterExpertise(parameters:[ String: Any]? ,completion: @escaping (Result<[ExpertiseModel]>) -> Void)
    func filterMemberShips(parameters:[ String: Any]? ,completion: @escaping (Result<[MembershipModel]>) -> Void)
    func sendUserFeedback(parameters: [String: Any]?, completion: @escaping (Result<UserFeedbackModel>) -> Void)
    func updateProfiledata(model:ProfileModel,profileImage:UIImage?,completion: @escaping (Result<RegistrationResponseModel>) -> Void)
    func getProfileData(completion: @escaping (Result<ProfileModel>) -> Void)
    func getUserData(path:String,completion: @escaping (Result<ProfileModel>) -> Void)
    
    func signOut(completion: @escaping (Result<UserTokenModel>) -> Void)
    
    func deleteAccount(completion: @escaping (Result<UserTokenModel>) -> Void)
    func createGroup(model:CreateGroupModel,completion: @escaping (Result<GroupResponseModel>) -> Void)
    func getGroups(completion: @escaping (Result<GroupListModel>) -> Void)
    func groupConversationSend(parameters: [String : Any]?, onProgress: @escaping (Double) -> (), path: String,completion: @escaping (Result<MessageModel>) -> Void)
    func getGroupConversation(parameters:[ String: Any]? ,path:String, page:Int,completion: @escaping (Result<ChatModel>) -> Void)
    func seenMessages(parameters:[ String: Any]? ,path:String,completion: @escaping (Result<RegistrationResponseModel>) -> Void)
    func notificationStatus(parameters:[ String: Any]? ,completion: @escaping (Result<NotificationStatusModel>) -> Void)
    func renameGroup(parameters:[ String: Any]? ,path:String,completion: @escaping (Result<RegistrationResponseModel>) -> Void)
}

final class ExpatLandRepository: ExpatLandRepositoryHandling {
   
    private let getRemoteDataSource: RemoteDataSourceHandling
    private let realmManager: RealmManagerDataSource
    lazy var helperQueue = DispatchQueue(label: "ExpatLandQueueService", qos: .default)
    fileprivate var dispatchgroup: DispatchGroup!
    
    
    init(withGetWeather getRemoteDataSource: RemoteDataSourceHandling = RemoteDataSource(),
         withRealmManager realmManager: RealmManagerDataSource = RealmManager(RealmProvider.default)) {
           self.getRemoteDataSource = getRemoteDataSource
           self.realmManager = realmManager
       }
    
    func signIn(parameters: [String : Any]?,completion: @escaping (Result<UserTokenModel>) -> Void) {
        
        self.getRemoteDataSource.signIn(parameters: parameters) { (result) in
            switch result {
            case .success(value: let value):
                if  let token = value.accessToken {
                    Constants.userDefaults.setValue(token, forKey: UserDefaultKeys.accessToken)
                }
                if  let tokenType = value.tokenType {
                    Constants.userDefaults.setValue(tokenType, forKey: UserDefaultKeys.tokenType)
                }
                if  let id = value.id {
                    Constants.userDefaults.setValue(id, forKey: UserDefaultKeys.userId)
                }
                completion(.success(value: value))
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
    }
    
    func getCities(parameters: [String : Any]?, completion: @escaping (Result<[CityModel]>) -> Void) {
        self.realmManager.fetchObject(with: RealmCity.self) { (cities) in
            completion(.success(value: cities.map{CityModel.mapFromPersistenceObject($0)}))
        }
        self.getRemoteDataSource.getCities(parameters: parameters) { (result) in
            switch result {
            case .success(value: let value):
                completion(.success(value: value))
                self.realmManager.writeObjects(with: value.map{ $0.mapToPersistenceObject()})
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
    }
    
    func getCountries(completion: @escaping (Result<[CountryModel]>) -> Void) {
        self.realmManager.fetchObject(with: RealmCountry.self) { (countries) in
            completion(.success(value: countries.map{CountryModel.mapFromPersistenceObject($0)}))
        }
        self.getRemoteDataSource.getCountries(parameters: nil) { (result) in
            switch result {
            case .success(value: let value):
                completion(.success(value: value))
                self.realmManager.writeObjects(with: value.map{ $0.mapToPersistenceObject()})
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
    }
    
    func getExpertise(completion: @escaping (Result<[ExpertiseModel]>) -> Void) {
        self.realmManager.fetchObject(with: RealmExpertise.self) { (expertise) in
            completion(.success(value: expertise.map{ExpertiseModel.mapFromPersistenceObject($0)}))
        }
        self.getRemoteDataSource.getExpertise(parameters: nil) { (result) in
            switch result {
            case .success(value: let value):
                completion(.success(value: value))
                self.realmManager.writeObjects(with: value.map{ $0.mapToPersistenceObject()})
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
    }
    
    func register(model: RegistrationModel, completion: @escaping (Result<RegistrationResponseModel>) -> Void) {
        self.getRemoteDataSource.register(model: model) { (result) in
            switch result {
            case .success(value: let value):
                completion(.success(value: value))
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
    }
    
    func getMemberships(completion: @escaping (Result<UserModel>) -> Void) {
        
    }
    
    
    func forgotPassword(parameters: [String : Any]?, completion: @escaping (Result<RegistrationResponseModel>) -> Void) {
        self.getRemoteDataSource.forgotPassword(parameters: parameters) { (result) in
            switch result {
            case .success(value: let value):
                completion(.success(value: value))
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
    }
    
    func resetPassword(parameters: [String : Any]?, completion: @escaping (Result<RegistrationResponseModel>) -> Void) {
        self.getRemoteDataSource.resetPassword(parameters: parameters) { (result) in
            switch result {
            case .success(value: let value):
                completion(.success(value: value))
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
    }
    
    func requestDefaultPassword(parameters: [String : Any]?, completion: @escaping (Result<RegistrationResponseModel>) -> Void) {
        self.getRemoteDataSource.requestDefaultPassword(parameters: parameters) { (result) in
            switch result {
            case .success(value: let value):
                completion(.success(value: value))
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
    }
    
    func verifyEmail(parameters: [String : Any]?, path:String,completion: @escaping (Result<RegistrationResponseModel>) -> Void) {
        self.getRemoteDataSource.verifyEmail(parameters: parameters,path:path) { (result) in
            switch result {
            case .success(value: let value):
                completion(.success(value: value))
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
    }
    func sendUserFeedback(parameters: [String : Any]?, completion: @escaping (Result<UserFeedbackModel>) -> Void) {
        self.getRemoteDataSource.sendUserFeedback(parameters: parameters) { result in
            switch result {
            case .success(value: let value):
                completion(.success(value: value))
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
    }
    
    // filtering
       
    func requestFiltering(parameters: [String : Any]?, completion: @escaping (Result<[FilteringModel]>) -> Void) {
        self.getRemoteDataSource.requestFiltering(parameters: parameters) { (result) in
            switch result {
            case .success(value: let value):
                completion(.success(value: value))
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
        
    }
       
       func requestRegions(parameters: [String : Any]?, completion: @escaping (Result<[RegionModel]>) -> Void) {
           self.realmManager.fetchObject(with: RealmRegion.self) { (countries) in
               completion(.success(value: countries.map{RegionModel.mapFromPersistenceObject($0)}))
           }
           self.getRemoteDataSource.requestRegions(parameters: nil) { (result) in
               switch result {
               case .success(value: let value):
                   completion(.success(value: value))
                
                   self.realmManager.writeObjects(with: value.map{ $0.mapToPersistenceObject()})
               case .failure(error: let error):
                   completion(.failure(error: error))
               }
           }
       }
       
       func filterCountries(parameters: [String : Any]?, completion: @escaping (Result<[CountryModel]>) -> Void) {
           self.realmManager.fetchObject(with: RealmCountry.self) { (countries) in
               completion(.success(value: countries.map{CountryModel.mapFromPersistenceObject($0)}))
           }
           self.getRemoteDataSource.filterCountries(parameters: parameters) { (result) in
               switch result {
               case .success(value: let value):
                   completion(.success(value: value))
                   self.realmManager.writeObjects(with: value.map{ $0.mapToPersistenceObject()})
               case .failure(error: let error):
                   completion(.failure(error: error))
               }
           }
       }
       
       func filterCities(parameters: [String : Any]?, completion: @escaping (Result<[CityModel]>) -> Void) {
           self.realmManager.fetchObject(with: RealmCity.self) { (cities) in
               completion(.success(value: cities.map{CityModel.mapFromPersistenceObject($0)}))
           }
           self.getRemoteDataSource.filterCities(parameters: parameters) { (result) in
               switch result {
               case .success(value: let value):
                   completion(.success(value: value))
                   self.realmManager.writeObjects(with: value.map{ $0.mapToPersistenceObject()})
               case .failure(error: let error):
                   completion(.failure(error: error))
               }
           }
       }
       
       func filterMemberShips(parameters: [String : Any]?, completion: @escaping (Result<[MembershipModel]>) -> Void) {
           self.realmManager.fetchObject(with: RealmMembership.self) { (countries) in
               completion(.success(value: countries.map{MembershipModel.mapFromPersistenceObject($0)}))
           }
           self.getRemoteDataSource.filterMemberShips(parameters: nil) { (result) in
               switch result {
               case .success(value: let value):
                   completion(.success(value: value))
                   self.realmManager.writeObjects(with: value.map{ $0.mapToPersistenceObject()})
               case .failure(error: let error):
                   completion(.failure(error: error))
               }
           }
       }
    
    
    func filterExpertise(parameters: [String : Any]?,completion: @escaping (Result<[ExpertiseModel]>) -> Void) {
        self.realmManager.fetchObject(with: RealmExpertise.self) { (expertise) in
            completion(.success(value: expertise.map{ExpertiseModel.mapFromPersistenceObject($0)}))
        }
        self.getRemoteDataSource.filterExpertise(parameters: nil) { (result) in
            switch result {
            case .success(value: let value):
                completion(.success(value: value))
                self.realmManager.writeObjects(with: value.map{ $0.mapToPersistenceObject()})
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
    }
       
    func getProfileData(completion: @escaping (Result<ProfileModel>) -> Void) {
        
        self.realmManager.fetchObject(with: RealmProfile.self) { (user) in
            
            if user.count > 0 {
                let sortedList = user.filter{ $0.id == Constants.userDefaults.getUserId()}
                if sortedList.first != nil {
                    completion(.success(value: sortedList.first.map{ProfileModel.mapFromPersistenceObject($0)}!))
                }
            }
        }
        self.getRemoteDataSource.getUser{ (result) in
            
            switch result {
            case .success(value: let value):
                completion(.success(value: value))
                self.realmManager.writeObject(with: value.mapToPersistenceObject())
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
    }
    func getUserData(path:String,completion: @escaping (Result<ProfileModel>) -> Void) {
 
        self.realmManager.fetchObject(with: RealmProfile.self) { (user) in
            
            if user.count > 0 {
                let sortedList = user.filter{ $0.id == Int(path)}
                if sortedList.first != nil {
                    completion(.success(value: sortedList.first.map{ProfileModel.mapFromPersistenceObject($0)}!))
                }
            }
        }
        
        self.getRemoteDataSource.getUserDetail(path: path,completion: { (result) in
            
            switch result {
            case .success(value: let value):
                completion(.success(value: value))
                self.realmManager.writeObject(with: value.mapToPersistenceObject())
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        })
    }
    func updateProfiledata(model: ProfileModel,profileImage:UIImage?, completion: @escaping (Result<RegistrationResponseModel>) -> Void) {
        self.getRemoteDataSource.updateModel(model: model, profileImage: profileImage) { (result) in
             switch result {
             case .success(value: let value):
                 completion(.success(value: value))
             case .failure(error: let error):
                 completion(.failure(error: error))
             }
         }
     }
      
    func signOut(completion: @escaping (Result<UserTokenModel>) -> Void) {
        self.getRemoteDataSource.signOut { (result) in
            switch result{
            case .success(value: let value) :
                completion(.success(value: value))
            case .failure(error: let error) :
                completion(.failure(error: error))
            }
        }
    }
    func deleteAccount(completion: @escaping (Result<UserTokenModel>) -> Void) {
        self.getRemoteDataSource.deleteAccount { (result) in
            switch result{
            case .success(value: let value) :
                completion(.success(value: value))
            case .failure(error: let error) :
                completion(.failure(error: error))
            }
        }
    }
    
    func createGroup(model: CreateGroupModel, completion: @escaping (Result<GroupResponseModel>) -> Void) {
        self.getRemoteDataSource.createGroup(model: model) { (result) in
            switch result {
            case .success(value: let value):
                completion(.success(value: value))
            case .failure(error: let error):
                completion(.failure(error: error))
            }
        }
    }
    
    func getGroups(completion: @escaping (Result<GroupListModel>) -> Void) {
        
        self.realmManager.fetchObject(with: RealmGroupList.self) { (list) in
            if list.count > 0 {
               
                if list.first != nil {
                    completion(.success(value: list.first.map{GroupListModel.mapFromPersistenceObject($0)}!))
                   
                }
            }
        }
        
        self.getRemoteDataSource.getGroups { (result) in
            switch result{
            case .success(value: let value) :
                completion(.success(value: value))
               
                self.realmManager.writeObject(with: value.mapToPersistenceObject())
            case .failure(error: let error) :
                completion(.failure(error: error))
            }
        }
    }
    
    func groupConversationSend(parameters: [String : Any]?, onProgress: @escaping (Double) -> (), path: String, completion: @escaping (Result<MessageModel>) -> Void) {
        self.getRemoteDataSource.groupConversationSend(parameters: parameters, onProgress: onProgress, path: path) { (result) in
            switch result{
            case .success(value: let value) :
                completion(.success(value: value))
            case .failure(error: let error) :
                completion(.failure(error: error))
            }
        }
    }
    
    func getGroupConversation(parameters: [String : Any]?, path: String, page:Int,completion: @escaping (Result<ChatModel>) -> Void) {
        
        if page == 1 {
            self.realmManager.fetchObject(with: RealmChat.self) { (list) in
                if list.count > 0 {
                    let sortedList = list.filter{ $0.id == Int(path)}
                    if sortedList.first != nil {
                        completion(.success(value: sortedList.first.map{ChatModel.mapFromPersistenceObject($0)}!))
                    }
                }
            }
        }
        
        self.getRemoteDataSource.getGroupConversation(parameters: parameters, path: path) { (result) in
            switch result{
            case .success(value: let value) :
                completion(.success(value: value))
                if page == 1 {
                    self.realmManager.writeObject(with: value.mapToPersistenceObject())
                }
            case .failure(error: let error) :
                completion(.failure(error: error))
            }
        }
    }
    
    func seenMessages(parameters: [String : Any]?, path: String, completion: @escaping (Result<RegistrationResponseModel>) -> Void) {
        self.getRemoteDataSource.seenMessages(parameters: parameters, path: path) { (result) in
            switch result{
            case .success(value: let value) :
                completion(.success(value: value))
            case .failure(error: let error) :
                completion(.failure(error: error))
            }
        }
    }
    
    func notificationStatus(parameters: [String : Any]?, completion: @escaping (Result<NotificationStatusModel>) -> Void) {
        
        self.getRemoteDataSource.notificationStatus(parameters: parameters) { (result) in
            switch result{
            case .success(value: let value) :
                completion(.success(value: value))
            case .failure(error: let error) :
                completion(.failure(error: error))
            }
        }
    }
    
    
    func renameGroup(parameters: [String : Any]?, path: String, completion: @escaping (Result<RegistrationResponseModel>) -> Void) {
        
        self.getRemoteDataSource.renameGroup(parameters: parameters, path: path) { (result) in
            switch result{
            case .success(value: let value) :
                completion(.success(value: value))
            case .failure(error: let error) :
                completion(.failure(error: error))
            }
        }
    }
    
   

}
