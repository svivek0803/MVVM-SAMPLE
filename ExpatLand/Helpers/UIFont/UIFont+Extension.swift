//
//  UIFont+Extension.swift
//  ExpatLand
//
//  Created by User on 02/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import UIKit


extension UIFont {
    class func printFontFamily(){
        for family in UIFont.familyNames {
            print("Family \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("Members----\(name)")
            }
        }
    }
    
    static func kAppDefaultFontRegular(ofSize size: CGFloat = 16) -> UIFont {
        let  widthFactor: CGFloat = 1
        return UIFont(name: Constants.FontName.regular, size: size * widthFactor)!
    }
    
    static func kAppDefaultFontBold(ofSize size: CGFloat = 16) -> UIFont {
        let  widthFactor: CGFloat = 1
        return UIFont(name: Constants.FontName.bold, size: size * widthFactor)!
    }
}
