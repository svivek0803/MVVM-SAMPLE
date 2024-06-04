//
//  RealmGroupData.swift
//  ExpatLand
//
//  Created by User on 13/01/22.
//  Copyright © 2022 cypress. All rights reserved.
//

import Foundation
import RealmSwift

class RealmGroupData: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var type: Int = 0
    @objc dynamic var createdBy: Int = 0
    @objc dynamic var name: String = ""
    var users = List<RealmUser>()

}
