//
//  UserTokenModel.swift
//  ExpatLand
//
//  Created by User on 03/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation

// MARK: - UserTokenModel
struct UserTokenModel: Codable {
    let accessToken, tokenType: String?
    let defaultPassword , id : Int?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case defaultPassword = "default_password"
        case id 
    }
}
