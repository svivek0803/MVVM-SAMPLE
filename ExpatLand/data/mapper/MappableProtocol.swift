//
//  MappableProtocol.swift
//  ExpatLand
//
//  Created by User on 06/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import RealmSwift

//MARK: - MappableProtocol
protocol MappableProtocol {
    
    associatedtype PersistenceType: Storable
    
    //MARK: - Method
    func mapToPersistenceObject() -> PersistenceType
    static func mapFromPersistenceObject(_ object: PersistenceType?) -> Self
    
}
