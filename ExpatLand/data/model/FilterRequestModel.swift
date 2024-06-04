//
//  FilterRequestModel.swift
//  ExpatLand
//
//  Created by User on 21/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation

// MARK: - FilterRequestModel
struct FilterRequestModel: Codable {
    var membershipId: Int? 
    var searchTerm: String = ""
    var expertiseIDS: [Int]?
    var  cityIDS: [Int]?
    var  regionIDS: [Int]?
    var  countryIDS: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case membershipId = "membership_id"
        case searchTerm = "search_term"
        case expertiseIDS = "expertise_ids"
        case cityIDS = "city_ids"
        case regionIDS = "region_ids"
        case countryIDS = "country_ids"
    }
    
    init() { }
    
    func toDictionary() -> [String:Any]
        {
            var dictionary = [String:Any]()
            dictionary["membership_id"] = membershipId
            dictionary["search_term"] = searchTerm
            dictionary["country_ids"] = countryIDS
            dictionary["region_ids"] = regionIDS
            dictionary["expertise_ids"] = expertiseIDS
            dictionary["city_ids"] = cityIDS
            return dictionary
        }
}
