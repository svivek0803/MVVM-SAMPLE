//
//  RealmLastConversation.swift
//  ExpatLand
//
//  Created by User on 11/01/22.
//  Copyright © 2022 cypress. All rights reserved.
//

import Foundation
import RealmSwift

class RealmLastConversation: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var userID: Int = 0
    @objc dynamic var type: Int = 0
    @objc dynamic var groupID: Int = 0
    @objc dynamic var message: String = ""
    @objc dynamic var createdAt: String = ""
    @objc dynamic var lastStatus: RealmLastStatus?
    @objc dynamic var lastConversationUserData: RealmLastConversationUserData?
    @objc dynamic var fileOriginalName: String = ""
    
    let users = List<RealmUser>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ id: Int ,_ type: Int ,_ userID:Int,_ groupID:Int,_ message:String,_ createdAt:String , _ fileOriginalName:String) {
        self.init()
        self.id = id
        self.userID = userID
        self.groupID = groupID
        self.message = message
        self.createdAt = createdAt
        self.type = type
        self.fileOriginalName = fileOriginalName
    }
}
