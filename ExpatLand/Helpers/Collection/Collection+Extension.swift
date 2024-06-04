//
//  Collection+Extension.swift
//  ExpatLand
//
//  Created by User on 10/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation

extension Array  {
    var indexedDictionary: [String: Element] {
        var result: [String: Element] = [:]
        enumerated().forEach({ result[String($0.offset)] = $0.element })
        return result
    }
}
