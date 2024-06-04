//
//  RemoteDataSource.swift
//  ExpatLand
//
//  Created by User on 03/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import PromiseKit
import RealmSwift


protocol RemoteDataSourceHandling: AnyObject {
   
    func signIn(parameters:[ String: Any]? ,completion: @escaping (Result<UserTokenModel>) -> Void)
    func getCities(parameters:[ String: Any]? ,completion: @escaping (Result<[CityModel]>) -> Void)
    func getCountries(parameters:[ String: Any]? ,completion: @escaping (Result<[CountryModel]>) -> Void)
    func getExpertise(parameters:[ String: Any]? ,completion: @escaping (Result<[ExpertiseModel]>) -> Void)
    func forgotPassword(parameters:[ String: Any]? ,completion: @escaping (Result<RegistrationResponseModel>) -> Void)
    func resetPassword(parameters:[ String: Any]? ,completion: @escaping (Result<RegistrationResponseModel>) -> Void)
    func requestDefaultPassword(parameters:[ String: Any]? ,completion: @escaping (Result<RegistrationResponseModel>) -> Void)
    func verifyEmail(parameters:[ String: Any]? ,path:String,completion: @escaping (Result<RegistrationResponseModel>) -> Void)
    func register(model:RegistrationModel,completion: @escaping (Result<RegistrationResponseModel>) -> Void)
    func requestFiltering(parameters:[ String: Any]? ,completion: @escaping (Result<[FilteringModel]>) -> Void)
    func requestRegions(parameters:[ String: Any]? ,completion: @escaping (Result<[RegionModel]>) -> Void)
    func filterCountries(parameters:[ String: Any]? ,completion: @escaping (Result<[CountryModel]>) -> Void)
    func filterCities(parameters:[ String: Any]? ,completion: @escaping (Result<[CityModel]>) -> Void)
    func filterExpertise(parameters:[ String: Any]? ,completion: @escaping (Result<[ExpertiseModel]>) -> Void)
    func filterMemberShips(parameters:[ String: Any]? ,completion: @escaping (Result<[MembershipModel]>) -> Void)
    func sendUserFeedback(parameters: [String: Any]?, completion: @escaping (Result<UserFeedbackModel>) -> Void)
    func updateModel(model:ProfileModel,profileImage:UIImage?,completion: @escaping (Result<RegistrationResponseModel>) -> Void)
    func signOut(completion: @escaping (Result<UserTokenModel>) -> Void)
    func deleteAccount(completion: @escaping (Result<UserTokenModel>) -> Void)
    func getUser(completion: @escaping (Result<ProfileModel>) -> Void)
    func getUserDetail(path:String,completion: @escaping (Result<ProfileModel>) -> Void)
    func createGroup(model:CreateGroupModel,completion: @escaping (Result<GroupResponseModel>) -> Void)
    func getGroups(completion: @escaping (Result<GroupListModel>) -> Void)
    func groupConversationSend(parameters: [String : Any]?, onProgress: @escaping (Double) -> (), path: String,completion: @escaping (Result<MessageModel>) -> Void)
    func getGroupConversation(parameters:[ String: Any]? ,path:String,completion: @escaping (Result<ChatModel>) -> Void)
    func seenMessages(parameters:[ String: Any]? ,path:String,completion: @escaping (Result<RegistrationResponseModel>) -> Void)
    func notificationStatus(parameters:[ String: Any]? ,completion: @escaping (Result<NotificationStatusModel>) -> Void)
    func renameGroup(parameters:[ String: Any]? ,path:String,completion: @escaping (Result<RegistrationResponseModel>) -> Void)
}


final class RemoteDataSource: RemoteDataSourceHandling {
   
    func getUser(completion: @escaping (Result<ProfileModel>) -> Void) {
        firstly {
            getNetworkHandler.requestAccount(parameters: [:])
        }.done { (model: ProfileModel) in
            
            completion(.success(value: model))
           
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    func getUserDetail(path:String,completion: @escaping (Result<ProfileModel>) -> Void) {
        firstly {
            getNetworkHandler.requestUserDetail(parameters: [:],path:path)
        }.done { (model: ProfileModel) in
            
            completion(.success(value: model))
           
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    private let getNetworkHandler: NetworkHandling
    
    
    init(withGetWeather getNetworkHandler: NetworkHandling = NetworkHandler()) {
           self.getNetworkHandler = getNetworkHandler
       }
    
    
    func signIn(parameters:[ String: Any]? ,completion: @escaping (Result<UserTokenModel>) -> Void)
    {
        firstly {
            getNetworkHandler.requestSignIn(parameters: parameters)
        }.done { (model: UserTokenModel) in
            
            completion(.success(value: model))
           
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    func getCities(parameters:[ String: Any]? ,completion: @escaping (Result<[CityModel]>) -> Void)
    {
        firstly {
            getNetworkHandler.requestCities(parameters: parameters)
        }.done { (model: [CityModel]) in
            
            completion(.success(value: model))
           
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    func getCountries(parameters:[ String: Any]? ,completion: @escaping (Result<[CountryModel]>) -> Void)
    {
        firstly {
            getNetworkHandler.requestCountries(parameters: parameters)
        }.done { (model: [CountryModel]) in
            
            completion(.success(value: model))
           
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    func getExpertise(parameters:[ String: Any]? ,completion: @escaping (Result<[ExpertiseModel]>) -> Void) {
       
        firstly {
            getNetworkHandler.requestExpertise(parameters: parameters)
        }.done { (model: [ExpertiseModel]) in
            
            completion(.success(value: model))
           
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    func forgotPassword(parameters:[ String: Any]? ,completion: @escaping (Result<RegistrationResponseModel>) -> Void) {
          
           firstly {
               getNetworkHandler.forgotPassword(parameters: parameters)
           }.done { (model: RegistrationResponseModel) in
               
               completion(.success(value: model))
              
           }.catch { (error) in
               Console.log(error.localizedDescription)
               completion(.failure(error: error))
           }.finally {
               
           }
       }
    
    func resetPassword(parameters:[ String: Any]? ,completion: @escaping (Result<RegistrationResponseModel>) -> Void) {
          
           firstly {
               getNetworkHandler.resetPassword(parameters: parameters)
           }.done { (model: RegistrationResponseModel) in
               
               completion(.success(value: model))
              
           }.catch { (error) in
               Console.log(error.localizedDescription)
               completion(.failure(error: error))
           }.finally {
               
           }
       }
    
    func requestDefaultPassword(parameters:[ String: Any]? ,completion: @escaping (Result<RegistrationResponseModel>) -> Void) {
          
           firstly {
               getNetworkHandler.requestDefaultPassword(parameters: parameters)
           }.done { (model: RegistrationResponseModel) in
               
               completion(.success(value: model))
              
           }.catch { (error) in
               Console.log(error.localizedDescription)
               completion(.failure(error: error))
           }.finally {
               
           }
       }
    
    func verifyEmail(parameters:[ String: Any]? ,path:String,completion: @escaping (Result<RegistrationResponseModel>) -> Void) {
          
           firstly {
            getNetworkHandler.verifyEmail(parameters: parameters, path: path)
           }.done { (model: RegistrationResponseModel) in
               
               completion(.success(value: model))
              
           }.catch { (error) in
               Console.log(error.localizedDescription)
               completion(.failure(error: error))
           }.finally {
               
           }
       }
    
    func register(model: RegistrationModel, completion: @escaping (Result<RegistrationResponseModel>) -> Void) {
        firstly {
            getNetworkHandler.register(parameters: model.toDictionary())
        }.done { (model: RegistrationResponseModel) in
            
            completion(.success(value: model))
           
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    func requestFiltering(parameters: [String : Any]?, completion: @escaping (Result<[FilteringModel]>) -> Void) {
        firstly {
            getNetworkHandler.requestFiltering(parameters: parameters)
        }.done { (model: [FilteringModel]) in
            
            completion(.success(value: model))
           
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    func requestRegions(parameters: [String : Any]?, completion: @escaping (Result<[RegionModel]>) -> Void) {
        firstly {
            getNetworkHandler.requestRegions(parameters: parameters)
        }.done { (model: [RegionModel]) in
            
            completion(.success(value: model))
           
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    func filterCountries(parameters: [String : Any]?, completion: @escaping (Result<[CountryModel]>) -> Void) {
        firstly {
            getNetworkHandler.filterCountries(parameters: parameters)
        }.done { (model: [CountryModel]) in
            
            completion(.success(value: model))
           
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    func filterCities(parameters: [String : Any]?, completion: @escaping (Result<[CityModel]>) -> Void) {
        firstly {
            getNetworkHandler.filterCities(parameters: parameters)
        }.done { (model: [CityModel]) in
            
            completion(.success(value: model))
           
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    func filterMemberShips(parameters: [String : Any]?, completion: @escaping (Result<[MembershipModel]>) -> Void) {
        firstly {
            getNetworkHandler.filterMemberShips(parameters: parameters)
        }.done { (model: [MembershipModel]) in
            
            completion(.success(value: model))
           
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    func filterExpertise(parameters:[ String: Any]? ,completion: @escaping (Result<[ExpertiseModel]>) -> Void) {
       
        firstly {
            getNetworkHandler.filterExpertise(parameters: parameters)
        }.done { (model: [ExpertiseModel]) in
            
            completion(.success(value: model))
           
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    
    func sendUserFeedback(parameters: [String : Any]?, completion: @escaping (Result<UserFeedbackModel>) -> Void) {
        firstly {
            getNetworkHandler.sendUserFeedback(parameters: parameters)
        }.done { (model: UserFeedbackModel) in
            completion(.success(value: model))
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    func updateModel(model: ProfileModel,profileImage:UIImage?, completion: @escaping (Result<RegistrationResponseModel>) -> Void) {
                firstly {
        getNetworkHandler.editAccount(parameters: model.toDictionary(),profileImage:profileImage)
           
        }.done { (model: RegistrationResponseModel) in
            
            completion(.success(value: model))
           
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    func signOut(completion: @escaping (Result<UserTokenModel>) -> Void) {
        firstly {
            getNetworkHandler.signOut()
            
        }.done { (model:UserTokenModel) in
            completion(.success(value: model))
            
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    func deleteAccount(completion: @escaping (Result<UserTokenModel>) -> Void) {
        firstly {
            getNetworkHandler.deleteAccount()
            
        }.done { (model:UserTokenModel) in
            completion(.success(value: model))
            
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    func createGroup(model: CreateGroupModel, completion: @escaping (Result<GroupResponseModel>) -> Void) {
        firstly {
            getNetworkHandler.createGroup(parameters: model.toDictionary())
        }.done { (model: GroupResponseModel) in
            
            completion(.success(value: model))
           
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    func getGroups(completion: @escaping (Result<GroupListModel>) -> Void) {
        firstly {
            getNetworkHandler.getGroups(parameters: nil)
            
        }.done { (model:GroupListModel) in
            completion(.success(value: model))
            
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    func groupConversationSend(parameters: [String : Any]?, onProgress: @escaping (Double) -> (), path: String, completion: @escaping (Result<MessageModel>) -> Void) {
        firstly {
            getNetworkHandler.groupConversationSend(parameters: parameters, onProgress: onProgress, path: path)
            
        }.done { (model:MessageModel) in
            completion(.success(value: model))
            
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    func getGroupConversation(parameters: [String : Any]?, path: String, completion: @escaping (Result<ChatModel>) -> Void) {
        firstly {
            getNetworkHandler.getGroupConversation(parameters: parameters, path: path)
            
        }.done { (model:ChatModel) in
            completion(.success(value: model))
            
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    func seenMessages(parameters: [String : Any]?, path: String, completion: @escaping (Result<RegistrationResponseModel>) -> Void) {
        firstly {
            getNetworkHandler.seenMessages(parameters: parameters, path: path)
            
        }.done { (model:RegistrationResponseModel) in
            completion(.success(value: model))
            
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    
    func notificationStatus(parameters:[ String: Any]? ,completion: @escaping (Result<NotificationStatusModel>) -> Void)
    {
        firstly {
            getNetworkHandler.notificationStatus(parameters: parameters)
            
        }.done { (model:NotificationStatusModel) in
            completion(.success(value: model))
            
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
    
    func renameGroup(parameters: [String : Any]?, path: String, completion: @escaping (Result<RegistrationResponseModel>) -> Void) {
        firstly {
            getNetworkHandler.renameGroup(parameters: parameters, path: path)
            
        }.done { (model:RegistrationResponseModel) in
            completion(.success(value: model))
            
        }.catch { (error) in
            Console.log(error.localizedDescription)
            completion(.failure(error: error))
        }.finally {
            
        }
    }
    
  
    
}
