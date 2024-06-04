//
//  RealmChat.swift
//  ExpatLand
//
//  Created by User on 13/01/22.
//  Copyright © 2022 cypress. All rights reserved.
//

import Foundation
import RealmSwift

class RealmChat: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var conversations: RealmConversation?
    @objc dynamic var groupData: RealmGroupData?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
