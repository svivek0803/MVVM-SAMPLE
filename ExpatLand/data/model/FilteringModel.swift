//
//  FilteringModel.swift
//  ExpatLand
//
//  Created by User on 16/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation

struct FilteringModel: Codable {
    let id: Int?
    let firstName, lastName: String?
    let title, profileImage: String?
    let membership: MembershipModel
    let cities: [CityModel]
    var isSelected:Bool?
    var showMessageButton:Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case title
        case profileImage = "profile_image"
        case membership, cities
        case isSelected
    }
}
