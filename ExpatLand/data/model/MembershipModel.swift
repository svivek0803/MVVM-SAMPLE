//
//  MembershipModel.swift
//  ExpatLand
//
//  Created by User on 16/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation

struct MembershipModel: Codable {
    let id: Int?
    let name: String?
    var selected:Bool?
}



//MARK: - MappableProtocol Implementation
extension MembershipModel: MappableProtocol{
    
    func mapToPersistenceObject() -> RealmMembership {
        let model = RealmMembership()
        model.id = id ?? 0
        model.name = name ?? ""
        return model
    }
    
    static func mapFromPersistenceObject(_ object: RealmMembership?) -> MembershipModel {
        return MembershipModel(id: object?.id , name: object?.name)
    }
    
}
