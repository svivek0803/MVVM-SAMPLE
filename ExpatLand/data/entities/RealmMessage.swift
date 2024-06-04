//
//  RealmMeassage.swift
//  ExpatLand
//
//  Created by User on 13/01/22.
//  Copyright © 2022 cypress. All rights reserved.
//


import Foundation
import RealmSwift

class RealmMessage: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var message: String = ""
    @objc dynamic var type: Int = 0
    @objc dynamic var userID: Int = 0
    @objc dynamic var groupID: Int = 0
    @objc dynamic var createdAt: String = ""
    @objc dynamic var updatedAt: String = ""
    @objc dynamic var fileOriginalName: String = ""
    @objc dynamic var user: RealmUser?
    @objc dynamic var isInformationMessage: Bool = false
    
   
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ id: Int ,_ message: String ,_ type:Int,_ userID:Int ,_ groupID: Int,_ createdAt: String , _ updatedAt: String , _ fileOriginalName:String ,_ isInformationMessage:Bool ) {
        self.init()
        self.id = id
        self.message = message
        self.type = type
        self.userID = userID
        self.groupID = groupID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.fileOriginalName = fileOriginalName
        self.isInformationMessage = isInformationMessage
    }
}


