//
//  RealmObject+Storable.swift
//  ExpatLand
//
//  Created by User on 06/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import RealmSwift

extension Object: Storable {
    
}

public struct Sorted {
    var key: String
    var ascending: Bool = true
}
