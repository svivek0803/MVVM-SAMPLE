//
//  RealmLastStatus.swift
//  ExpatLand
//
//  Created by User on 11/01/22.
//  Copyright © 2022 cypress. All rights reserved.
//

import Foundation
import RealmSwift

class RealmLastStatus: Object {
    
    @objc dynamic var conversationID: Int = 0
    @objc dynamic var status: Int = 0
   
    override static func primaryKey() -> String? {
        return "conversationID"
    }
    
    convenience init(_ conversationID: Int ,_ status: Int ) {
        self.init()
        self.conversationID = conversationID
        self.status = status
    }
}
