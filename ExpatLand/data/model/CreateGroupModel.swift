//
//  CreateGroupModel.swift
//  ExpatLand
//
//  Created by User on 03/01/22.
//  Copyright © 2022 cypress. All rights reserved.
//

import Foundation

// MARK: - CreateGroupModel
struct CreateGroupModel: Codable {
    var users: [Int] = []
    var  type: Int?
    
    enum CodingKeys: String, CodingKey {
        case users = "users"
        case type = "type"
    }
    
    init() { }
    
    func toDictionary() -> [String:Any]
        {
            var dictionary = [String:Any]()
            dictionary["users"] = users
            dictionary["type"] = type
            return dictionary
        }
}
