//
//  Resource.swift
//  ExpatLand
//
//  Created by User on 03/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import Alamofire


struct MultiPart{
    let data: Data
    let fileNameWithExt: String
    let serverKey: String
    let mimeType: MediaType
}
enum MediaType: String {
    case image = "image/png"
    case video = "video/mov"
    case file  = "application/octet-stream"
}

enum Resource {
    
    case signIn
    case account
    case cities
    case countries
    case expertise
    case memberships
    case contactUs
    case signUp
    case defaultPassword
    case verifyEmail
    case forgotPassword
    case resetPassword
    case signOut
    case deleteAccount
    case editAccount
    case users
    case filtering
    case regions
    case filterCountries
    case filterCities
    case filterMemberShips
    case filterExpertise
    case createGroup
    case getGroup
    case groupConversationSend
    case getGroupConversation
    case seenMessages
    case notificationStatus
    case renameGroup
    
    var resource: (method: HTTPMethod, endPoint: String) {
        switch self {
        case .signIn:
            return (.post, Constants.APIEndpoint.signIn.rawValue)
        case .account:
            return (.get, Constants.APIEndpoint.account.rawValue)
        case .cities:
            return (.get, Constants.APIEndpoint.cities.rawValue)
        case .countries:
            return (.get, Constants.APIEndpoint.countries.rawValue)
        case .expertise:
            return (.get, Constants.APIEndpoint.expertise.rawValue)
        case .memberships:
            return (.get, Constants.APIEndpoint.memberships.rawValue)
        case .contactUs:
            return (.post, Constants.APIEndpoint.contactUs.rawValue)
        case .signUp:
            return (.post, Constants.APIEndpoint.signUp.rawValue)
        case .defaultPassword:
            return (.put, Constants.APIEndpoint.defaultPassword.rawValue)
        case .verifyEmail:
            return (.get, Constants.APIEndpoint.verifyEmail.rawValue)
        case .forgotPassword:
            return (.post, Constants.APIEndpoint.forgotPassword.rawValue)
        case .resetPassword:
            return (.post, Constants.APIEndpoint.resetPassword.rawValue)
        case .signOut:
            return (.post, Constants.APIEndpoint.signOut.rawValue)
        case .deleteAccount:
            return (.delete, Constants.APIEndpoint.deleteAccount.rawValue)
        case .editAccount:
            return (.post, Constants.APIEndpoint.editAccount.rawValue)
        case .filtering:
            return (.get, Constants.APIEndpoint.filtering.rawValue)
        case .regions:
            return (.get, Constants.APIEndpoint.regions.rawValue)
        case .filterCountries:
            return (.get, Constants.APIEndpoint.filterCountries.rawValue)
        case .filterCities:
            return (.get, Constants.APIEndpoint.filterCities.rawValue)
        case .filterMemberShips:
            return (.get, Constants.APIEndpoint.filterMemberShips.rawValue)
        case .filterExpertise:
            return (.get, Constants.APIEndpoint.filterExpertise.rawValue)
        case .users:
            return(.get,Constants.APIEndpoint.users.rawValue)
        case .createGroup:
            return(.post,Constants.APIEndpoint.createGroup.rawValue)
        case .getGroup:
            return(.get,Constants.APIEndpoint.getGroup.rawValue)
        case .groupConversationSend:
            return(.post,Constants.APIEndpoint.groupConversationSend.rawValue)
        case .getGroupConversation:
            return(.get,Constants.APIEndpoint.getGroupConversation.rawValue)
        case .seenMessages:
            return(.put,Constants.APIEndpoint.seenMessages.rawValue)
        case .notificationStatus:
            return(.put,Constants.APIEndpoint.notificationStatus.rawValue)
        case .renameGroup:
            return(.put,Constants.APIEndpoint.renameGroup.rawValue)
            
        }
    }
}


public enum Result<T> {
    case success(value:T)
    case failure(error: Error)
    
}
