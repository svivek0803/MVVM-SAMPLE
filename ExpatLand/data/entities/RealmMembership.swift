//
//  RealmMembership.swift
//  ExpatLand
//
//  Created by User on 16/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMembership: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
   
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ id: Int ,_ name: String ) {
        self.init()
        self.id = id
        self.name = name
    }
}
