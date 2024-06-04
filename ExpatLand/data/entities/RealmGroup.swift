//
//  RealmGroup.swift
//  ExpatLand
//
//  Created by User on 11/01/22.
//  Copyright © 2022 cypress. All rights reserved.
//

import Foundation
import RealmSwift

class RealmGroup: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var type: Int = 0
    @objc dynamic var unseenCount: Int = 0
    @objc dynamic var lastConversation: RealmLastConversation?
    @objc dynamic var name: String = ""

    let users = List<RealmUser>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ id: Int ,_ type: Int , _ unseenCount: Int , _ name: String) {
        self.init()
        self.id = id
        self.type = type
        self.unseenCount = unseenCount
        self.name = name
    }
}
