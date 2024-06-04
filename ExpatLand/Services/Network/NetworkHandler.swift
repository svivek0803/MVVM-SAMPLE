//
//  NetworkHandler.swift
//  ExpatLand
//
//  Created by User on 03/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import PromiseKit

protocol NetworkHandling: AnyObject {
    func requestSignIn<T: Decodable>(parameters:[ String: Any]?) -> Promise<T>
    func requestAccount<T: Decodable>(parameters:[ String: Any]?) -> Promise<T>
    func requestUserDetail<T: Decodable>(parameters:[ String: Any]?,path:String) -> Promise<T>
    func requestCities<T: Decodable>(parameters:[ String: Any]?) -> Promise<T>
    func requestCountries<T: Decodable>(parameters:[ String: Any]?) -> Promise<T>
    func requestExpertise<T: Decodable>(parameters:[ String: Any]?) -> Promise<T>
    func requestMemberships<T: Decodable>(parameters:[ String: Any]?) -> Promise<T>
    func forgotPassword<T: Decodable>(parameters:[ String: Any]?) -> Promise<T>
    func resetPassword<T: Decodable>(parameters:[ String: Any]?) -> Promise<T>
    func requestDefaultPassword<T: Decodable>(parameters:[ String: Any]?) -> Promise<T>
    func verifyEmail<T: Decodable>(parameters:[ String: Any]?,path:String) -> Promise<T>
    func register<T: Decodable>(parameters:[ String: Any]?) -> Promise<T>
    func requestFiltering<T: Decodable>(parameters:[ String: Any]?) -> Promise<T>
    func requestRegions<T: Decodable>(parameters:[ String: Any]?) -> Promise<T>
    func filterCountries<T: Decodable>(parameters:[ String: Any]?) -> Promise<T>
    func filterCities<T: Decodable>(parameters:[ String: Any]?) -> Promise<T>
    func filterMemberShips<T: Decodable>(parameters:[ String: Any]?) -> Promise<T>
    func filterExpertise<T: Decodable>(parameters:[ String: Any]?) -> Promise<T>
    func sendUserFeedback<T: Decodable>(parameters: [String: Any]?) -> Promise<T>
    func editAccount<T: Decodable>(parameters:[ String: Any]?,profileImage:UIImage?) -> Promise<T>
    func signOut<T:Decodable>() -> Promise<T>
    func deleteAccount<T:Decodable>() -> Promise<T>
    func createGroup<T: Decodable>(parameters:[ String: Any]?) -> Promise<T>
    func getGroups<T: Decodable>(parameters:[ String: Any]?) -> Promise<T>
    func groupConversationSend<T: Decodable>( parameters: [String: Any]? , onProgress: @escaping (Double)-> (),path:String) -> Promise<T>
    func getGroupConversation<T: Decodable>(parameters:[ String: Any]?,path:String) -> Promise<T>
    func seenMessages<T: Decodable>(parameters:[ String: Any]?,path:String) -> Promise<T>
    func notificationStatus<T: Decodable>(parameters:[ String: Any]?) -> Promise<T>
    func renameGroup<T: Decodable>(parameters: [String : Any]?, path: String) -> Promise<T>
    
}

final class NetworkHandler: NetworkHandling {
    
    private let webService: NetworkServiceProtocol
    
    init(withWebService webService: NetworkServiceProtocol = WebService()) {
        self.webService = webService
    }
    
    func requestSignIn<T>(parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        self.webService.request(with: .signIn, parameters:  parameters)
    }
    
    func requestAccount<T>(parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        self.webService.request(with: .account, parameters:  parameters)
    }
    func requestUserDetail<T>(parameters: [String : Any]?,path:String) -> Promise<T> where T : Decodable {
        self.webService.requestWithPath(with: .users, parameters: parameters, path: path)
    }
    
    func requestCities<T>(parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        self.webService.request(with: .cities, parameters:  parameters)
    }
    
    func requestCountries<T>(parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        self.webService.request(with: .countries, parameters:  parameters)
    }
    
    func requestExpertise<T>(parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        self.webService.request(with: .expertise, parameters:  parameters)
    }
    
    func requestMemberships<T>(parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        self.webService.request(with: .memberships, parameters:  parameters)
    }
    
    func filterExpertise<T>(parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        self.webService.request(with: .filterExpertise, parameters:  parameters)
    }
    
    func forgotPassword<T>(parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        self.webService.request(with: .forgotPassword, parameters:  parameters)
    }
    
    func resetPassword<T>(parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        self.webService.request(with: .resetPassword, parameters:  parameters)
    }
    
    func requestDefaultPassword<T>(parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        self.webService.request(with: .defaultPassword, parameters:  parameters)
    }
    
    func verifyEmail<T>(parameters: [String : Any]?,path:String) -> Promise<T> where T : Decodable {
        self.webService.requestWithPath(with: .verifyEmail, parameters: parameters, path: path)
    }
    
    func register<T>(parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        self.webService.requestWithBody(with: .signUp, parameters: parameters)
    }
    
    func requestFiltering<T>(parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        self.webService.requestWithURLEncoding(with: .filtering, parameters:  parameters)
    }
    
    func requestRegions<T>(parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        self.webService.request(with: .regions, parameters:  parameters)
    }
    
    func filterCountries<T>(parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        self.webService.request(with: .filterCountries, parameters:  parameters)
    }
    
    func filterCities<T>(parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        self.webService.request(with: .filterCities, parameters:  parameters)
    }
    
    func filterMemberShips<T>(parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        self.webService.request(with: .filterMemberShips, parameters:  parameters)
    }
    func sendUserFeedback<T>(parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        self.webService.request(with: .contactUs, parameters: parameters)
    }
    func signOut<T>() -> Promise<T> where T : Decodable {
        self.webService.request(with: .signOut, parameters: [:])
    }
    
    func deleteAccount<T>() -> Promise<T> where T : Decodable {
        self.webService.request(with: .deleteAccount, parameters: [:])
    }
    
    func editAccount<T>(parameters: [String : Any]?,profileImage:UIImage?) -> Promise<T> where T : Decodable {
        self.webService.requestWithFormData(with: .editAccount, parameters: parameters ?? [:], profileImage: profileImage ?? nil)
       // requestWithFormData(with: .editAccount, parameters: parameters)
    }
    
    func createGroup<T>(parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        self.webService.requestWithBody(with: .createGroup, parameters: parameters)
    }
    
    func getGroups<T>(parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        self.webService.request(with: .getGroup, parameters:  parameters)
    }
    
    func groupConversationSend<T>(parameters: [String : Any]?, onProgress: @escaping (Double) -> (), path: String) -> Promise<T> where T : Decodable {
        self.webService.requestFormDataWithPath(with: .groupConversationSend, parameters: parameters, onProgress: onProgress, path: path)
    }
    
    func getGroupConversation<T>(parameters: [String : Any]?, path: String) -> Promise<T> where T : Decodable {
        self.webService.requestWithPath(with: .getGroupConversation, parameters: parameters, path: path)
    }
    
    func seenMessages<T>(parameters: [String : Any]?, path: String) -> Promise<T> where T : Decodable {
        self.webService.requestWithPath(with: .seenMessages, parameters: parameters, path: path)
    }
    
    func notificationStatus<T>(parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        self.webService.request(with: .notificationStatus, parameters:  parameters)
    }
    
    func renameGroup<T>(parameters: [String : Any]?, path: String) -> Promise<T> where T : Decodable {
        self.webService.requestWithPath(with: .renameGroup, parameters: parameters, path: path)
    }
}
