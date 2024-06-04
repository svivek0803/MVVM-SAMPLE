//
//  RealmCity.swift
//  ExpatLand
//
//  Created by User on 06/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var countryID: Int = 0
    @objc dynamic var name: String = ""
   
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ id: Int ,_ countryID:Int ,_ name: String ) {
        self.init()
        self.id = id
        self.countryID = countryID
        self.name = name
    }
}
