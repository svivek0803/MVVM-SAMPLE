//
//  CountryModel.swift
//  ExpatLand
//
//  Created by User on 06/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation

struct CountryModel: Codable {
    let id: Int?
    let name: String?
    var selected:Bool?
}



//MARK: - MappableProtocol Implementation
extension CountryModel: MappableProtocol{
    
    func mapToPersistenceObject() -> RealmCountry {
        let model = RealmCountry()
        model.id = id ?? 0
        model.name = name ?? ""
        return model
    }
    
    static func mapFromPersistenceObject(_ object: RealmCountry?) -> CountryModel {
        return CountryModel(id: object?.id , name: object?.name)
    }
    
}
