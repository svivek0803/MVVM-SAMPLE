//
//  RealmGroupList.swift
//  ExpatLand
//
//  Created by User on 11/01/22.
//  Copyright © 2022 cypress. All rights reserved.
//

import Foundation
import RealmSwift

class RealmGroupList: Object {
    
    @objc dynamic var id: Int = 0
    var groups = List<RealmGroup>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ id: Int) {
        self.init()
        self.id = id
    }
}
