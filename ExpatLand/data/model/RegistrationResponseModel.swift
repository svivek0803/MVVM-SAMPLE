//
//  RegistrationResponseModel.swift
//  ExpatLand
//
//  Created by User on 09/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation

// MARK: - RegistrationResponseModel
struct RegistrationResponseModel: Codable {
    let message: String?
    let whitelisting: Bool?
    let errors: Errors?
    
}
// MARK: - RegistrationResponseModel
struct ProfileResponseModel: Codable {
    let message: String?
    let errors: Errors?
    
}

// MARK: - Errors
struct Errors: Codable {
    let email, secondaryEmail: [String]?

    enum CodingKeys: String, CodingKey {
        case email
        case secondaryEmail = "secondary_email"
    }
}
