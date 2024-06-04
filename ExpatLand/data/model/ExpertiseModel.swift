//
//  ExpertiseModel.swift
//  ExpatLand
//
//  Created by User on 07/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation

struct ExpertiseModel: Codable {
    let id: Int?
    let name: String?
    var selected:Bool?
}



//MARK: - MappableProtocol Implementation
extension ExpertiseModel: MappableProtocol{
    
    func mapToPersistenceObject() -> RealmExpertise {
        let model = RealmExpertise()
        model.id = id ?? 0
        model.name = name ?? ""
        return model
    }
    
    static func mapFromPersistenceObject(_ object: RealmExpertise?) -> ExpertiseModel {
        return ExpertiseModel(id: object?.id , name: object?.name)
    }
    
}
