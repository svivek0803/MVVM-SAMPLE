//
//  CustomTextView.swift
//  ExpatLand
//
//  Created by User on 11/01/22.
//  Copyright © 2022 cypress. All rights reserved.
//

import Foundation
import UIKit

class CustomTextView: UITextView {
    override func caretRect(for position: UITextPosition) -> CGRect {
            var superRect = super.caretRect(for: position)
            guard let font = self.font else { return superRect }

            // "descender" is expressed as a negative value,
            // so to add its height you must subtract its value
            superRect.size.height = font.pointSize - font.descender
            return superRect
        }
}
