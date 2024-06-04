//
//  RegionModel.swift
//  ExpatLand
//
//  Created by User on 16/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation

struct RegionModel: Codable {
    let id: Int?
    let name: String?
    var selected:Bool?
}



//MARK: - MappableProtocol Implementation
extension RegionModel: MappableProtocol{
    
    func mapToPersistenceObject() -> RealmRegion {
        let model = RealmRegion()
        model.id = id ?? 0
        model.name = name ?? ""
        return model
    }
    
    static func mapFromPersistenceObject(_ object: RealmRegion?) -> RegionModel {
        return RegionModel(id: object?.id , name: object?.name)
    }
    
}
