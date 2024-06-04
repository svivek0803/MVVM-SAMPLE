//
//  TableView+Extensions.swift
//  ExpatLand
//
//  Created by User on 03/01/22.
//  Copyright © 2022 cypress. All rights reserved.
//

import UIKit

extension UITableView{
    func indexPathForView(_ view: UIView) -> IndexPath? {
         let center = view.center
         let viewCenter = convert(center, from: view.superview)
         let indexPath = indexPathForRow(at: viewCenter)
         return indexPath
     }
}
