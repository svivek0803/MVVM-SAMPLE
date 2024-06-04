//
//  RealmLastConversationUserData.swift
//  ExpatLand
//
//  Created by User on 11/01/22.
//  Copyright © 2022 cypress. All rights reserved.
//

import Foundation
import RealmSwift

class RealmLastConversationUserData: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    
   
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ id: Int ,_ firstName: String , _ lastName: String  ) {
        self.init()
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
}
