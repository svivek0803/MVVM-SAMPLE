//
//  CityModel.swift
//  ExpatLand
//
//  Created by User on 06/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation

struct CityModel: Codable {
    let id: Int?
    let name: String?
    let countryID: Int?
    var selected:Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, name ,selected
        case countryID = "country_id"
    }
}



//MARK: - MappableProtocol Implementation
extension CityModel: MappableProtocol{
    
    func mapToPersistenceObject() -> RealmCity {
        let model = RealmCity()
        model.id = id ?? 0
        model.countryID = countryID ?? 0
        model.name = name ?? ""
        return model
    }
    
    static func mapFromPersistenceObject(_ object: RealmCity?) -> CityModel {
        return CityModel(id: object?.id , name: object?.name, countryID: object?.countryID)
    }
    
}
