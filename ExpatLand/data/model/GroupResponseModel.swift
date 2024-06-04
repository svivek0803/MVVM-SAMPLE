//
//  GroupResponseModel.swift
//  ExpatLand
//
//  Created by User on 03/01/22.
//  Copyright © 2022 cypress. All rights reserved.
//

import Foundation

// MARK: - GroupResponseModel
struct GroupResponseModel: Codable {
    let id, type: Int?
    let createdAt, updatedAt: String?
    let users: [UserModel]?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case id, type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case users,message
    }
}
