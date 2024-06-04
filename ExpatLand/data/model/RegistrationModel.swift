//
//  RegistrationModel.swift
//  ExpatLand
//
//  Created by User on 09/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation

// MARK: - RegistrationModel
struct RegistrationModel: Codable {
    var email: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var company: String = ""
    var password: String = ""
    var secondaryEmail: String = ""
    var expertiseIDS: [Int] = []
    var  cityIDS: [Int] = []
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case company, email, password
        case secondaryEmail = "secondary_email"
        case expertiseIDS = "expertise_ids"
        case cityIDS = "city_ids"
    }
    
    init() { }
    
    func toDictionary() -> [String:Any]
        {
            var dictionary = [String:Any]()
            dictionary["email"] = email
            dictionary["first_name"] = firstName
            dictionary["last_name"] = lastName
            dictionary["company"] = company
            dictionary["password"] = password
            dictionary["secondary_email"] = secondaryEmail
            dictionary["expertise_ids"] = expertiseIDS
            dictionary["city_ids"] = cityIDS
            return dictionary
        }
}
