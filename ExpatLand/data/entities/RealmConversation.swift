//
//  RealmConversation.swift
//  ExpatLand
//
//  Created by User on 11/01/22.
//  Copyright © 2022 cypress. All rights reserved.
//

import Foundation
import RealmSwift

class RealmConversation: Object {
    
    @objc dynamic var currentPage: Int = 0
    var data = List<RealmMessage>()
    @objc dynamic var firstPageURL: String = ""
    @objc dynamic var from: Int = 0
    @objc dynamic var lastPage: Int = 0
    @objc dynamic var lastPageURL: String = ""
    @objc dynamic var nextPageURL: String = ""
    @objc dynamic var path: String = ""
    @objc dynamic var perPage: Int = 0
    @objc dynamic var prevPageURL: String = ""
    @objc dynamic var to: Int = 0
    @objc dynamic var total: Int = 0
    @objc dynamic var id: String = "0"
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

