//
//  UITextView+Extension.swift
//  ExpatLand
//
//  Created by User on 11/01/22.
//  Copyright © 2022 cypress. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {

    func centerVerticalText() {
        self.textAlignment = .center
        let fitSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fitSize)
        let calculate = (bounds.size.height - size.height * zoomScale) / 2
        let offset = max(1, calculate)
        contentOffset.y = -offset
    }
    
    func numberOfLines() -> Int{
            if let fontUnwrapped = self.font{
                return Int(self.contentSize.height / fontUnwrapped.lineHeight)
            }
            return 0
        }
}
