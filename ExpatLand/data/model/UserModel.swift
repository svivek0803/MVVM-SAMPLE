//
//  UserModel.swift
//  ExpatLand
//
//  Created by User on 03/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import UIKit


// MARK: - UserModel
struct UserModel: Codable {
    var id: Int?
    var firstName, lastName: String?
    var title, phoneNumber: String?
    var company, email, secondaryEmail: String?
    var expertises: [ExpertiseModel]?
    var membership: MembershipModel?
    var countries: [CountryModel]?
    var cities: [CityModel]?
    var expertiseIDs : [Int]?
    var cityIDS : [Int]?
    var profileImageURL:String?
    let membershipID: Int?
    var notificationStatus: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case profileImageURL = "profile_image"
        case title
        case phoneNumber = "phone_number"
        case company, email
        case secondaryEmail = "secondary_email"
        case expertises, membership, countries, cities
        case membershipID = "membership_id"
        case notificationStatus = "notification_status"
//        case cityIDs = "city_ids"
//        case expertiseIDS = "expertise_ids"
        
        
    }
    func toDictionary()->[String:Any]{
        
        var dictionary = [String:Any]()
        dictionary["first_name"] = firstName
        dictionary["last_name"] = lastName
        dictionary["title"] = title
        dictionary["phone_number"] = phoneNumber
        dictionary["profile_image"] = profileImageURL
        dictionary["company"] = company
        dictionary["secondary_email"] = secondaryEmail
        dictionary["city_ids"] = cityIDS
        dictionary["expertise_ids"] = expertiseIDs
      return dictionary
    }
}

// MARK: - City
struct City: Codable {
    let id: Int?
    let name: String?
    let countryID: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case countryID = "country_id"
    }
}

// MARK: - Membership
struct Membership: Codable {
    let id: Int?
    let name: String?
}



// MARK: - MappableProtocol Implementation
extension UserModel: MappableProtocol{

    func mapToPersistenceObject() -> RealmUser {
        let model = RealmUser()
        model.id = id ?? 0
        model.name =  ""
        model.email = email ?? ""
        model.number = phoneNumber ?? ""
        model.firstName = firstName ?? ""
        model.lastName = lastName ?? ""
        model.company = company ?? ""
        model.secondaryEmail = secondaryEmail ?? ""
        model.phoneNumber = phoneNumber ?? ""
        model.title = title ?? ""
        model.profileImageURL  = profileImageURL ?? ""
        model.membershipID = membershipID ?? 0
        model.notificationStatus = notificationStatus ?? 0
        model.membership = membership?.mapToPersistenceObject()
        model.expertises.append(objectsIn: expertises?.map{ $0.mapToPersistenceObject() } ?? [])
        model.countries.append(objectsIn: countries?.map{ $0.mapToPersistenceObject() } ?? [] )
        model.cities.append(objectsIn: cities?.map{ $0.mapToPersistenceObject() } ?? [])
        return model
    }

    static func mapFromPersistenceObject(_ object: RealmUser?) -> UserModel {
        return UserModel(id: object?.id, firstName:object?.firstName,lastName: object?.lastName,title: object?.title, phoneNumber:object?.phoneNumber,company:object?.company, email: object?.email,secondaryEmail:object?.secondaryEmail  ,expertises:object?.expertises.map{ ExpertiseModel.mapFromPersistenceObject($0)}, membership: MembershipModel.mapFromPersistenceObject(object?.membership),countries: object?.countries.map{ CountryModel.mapFromPersistenceObject($0)},cities:object?.cities.map{ CityModel.mapFromPersistenceObject($0)},  profileImageURL:object?.profileImageURL ,membershipID: object?.membershipID,notificationStatus:object?.notificationStatus )
    }

}






