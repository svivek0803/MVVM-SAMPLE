//
//  UILabel+Extension.swift
//  ExpatLand
//
//  Created by User on 30/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setMargins(_ margin: CGFloat = 10) {
        if let textString = self.text {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.firstLineHeadIndent = margin
            paragraphStyle.headIndent = margin
            paragraphStyle.tailIndent = -margin
            paragraphStyle.alignment = .center
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
    
    func addTrailing(image: UIImage, text:String) {
        let attachment = NSTextAttachment()
        attachment.image = image
        let iconsSize = CGRect(x: 0, y: 0, width: 12, height: 12)
        attachment.bounds = iconsSize
        let attachmentString = NSAttributedString(attachment: attachment)
        let string = NSMutableAttributedString(string: text, attributes: [:])

        string.append(attachmentString)
        self.attributedText = string
    }
       
       func addLeading(image: UIImage, text:String) {
           let attachment = NSTextAttachment()
           attachment.image = image

           let attachmentString = NSAttributedString(attachment: attachment)
           let mutableAttributedString = NSMutableAttributedString()
           mutableAttributedString.append(attachmentString)
           
           let string = NSMutableAttributedString(string: text, attributes: [:])
           mutableAttributedString.append(string)
           self.attributedText = mutableAttributedString
       }
}
