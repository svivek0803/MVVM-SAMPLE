//
//  String+Extensions.swift
//  ExpatLand
//
//  Created by User on 02/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import UIKit

extension String {
    static func getString(_ message: Any?) -> String {
        if let string = message {
            guard let strMessage = string as? String else {
                guard let doubleValue = string as? Double else {
                    guard let intValue = string as? Int else {
                        guard string is Float else {
                            guard let int64Value = string as? Int64 else {
                                guard let int32Value = string as? Int32 else {
                                    guard let int16Value = string as? Int32 else {
                                        return ""
                                    }
                                    return String(int16Value)
                                }
                                return String(int32Value)
                            }
                            return String(int64Value)
                        }
                        return String(format: "%.2f", string as! Float)
                    }
                    return String(intValue)
                }
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 2
                formatter.minimumIntegerDigits = 1
                guard let formattedNumber = formatter.string(from: NSNumber(value: doubleValue)) else {
                    return ""
                }
                return formattedNumber
            }
            return strMessage
        }
        return ""
    }
    var html2AttributedString: NSAttributedString? {
        //        guard
        //            let data = data(using: String.Encoding.utf16)
        //            else { return nil }
        do {
            return try NSAttributedString(data: Data(utf8), options: [.documentType:NSAttributedString.DocumentType.html,.characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch  {
            return  nil
        }
    }
    
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9]{6,14}$";
        let valid = NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone)
        return valid
    }
    
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9.-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isValidPassword()-> Bool {
        let regex = try! NSRegularExpression(pattern: "", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
   
    static func randomString() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...9).map{ _ in letters.randomElement()! })
    }
    
    static func getString(_ value: Int?) -> String{
        if let value = value {
            return "\(value)"
        }
        return ""
    }
    
    func characterCount(str: String) -> Int {
        let s = str.count
        return s
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
   
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "\(self)", comment: "")
    }
    
    var withoutHtmlTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: " \n", options:
            .regularExpression, range: nil).replacingOccurrences(of: "&[^;]+;", with:
                "", options:.regularExpression, range: nil)
    }
    func checkForValidLength(min: Int, max: Int) -> Bool{
        return self.count >= min && self.count <= max
    }
    static func join(strings: [String?]?, separator: String) -> String {
        guard let strings = strings else{return ""}
        return strings.compactMap { $0 }.joined(separator: separator)
    }
   
    func trimFromLeading() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil , fontSize: CGFloat = 12) -> NSAttributedString {
            let attributedString = NSMutableAttributedString(string: self)
        let boldFontAttribute = [NSAttributedString.Key.font:UIFont.kAppDefaultFontBold(ofSize: fontSize)]
            for string in strings {
                let originalString = self.lowercased()
                let range = (originalString as NSString).range(of: string)
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
                attributedString.addAttributes(boldFontAttribute, range: range)
            }

            guard let characterSpacing = characterSpacing else {return attributedString}

            attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

            return attributedString
        }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
          let fontAttributes = [NSAttributedString.Key.font: font]
          let size = self.size(withAttributes: fontAttributes)
          return size.width
      }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func estimateFrameForText() -> CGRect {
      let size = CGSize(width: 200, height: 10000)
      let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: UIFont.kAppDefaultFontRegular(ofSize: 14)]
      return self.boundingRect(with: size, options: options, attributes: attributes, context: nil).integral
    }

    func estimateFrameForText(width: CGFloat,  font: UIFont) -> CGRect {
      let size = CGSize(width: width, height: 10000)
      let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
          let attributes = [NSAttributedString.Key.font: font]
      return self.boundingRect(with: size, options: options, attributes: attributes, context: nil).integral
    }
    
    func getTimeStamp()->String
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        if let date = dateFormatter.date(from: self) {
                return date.getTimeStringFromUTC()
        }
        
        return ""
    }
    
    func getDate()->Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
       // dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        if let date = dateFormatter.date(from: self) {
            
            return date
        }
        
        return Date()
    }
    
    func toJSON() -> Any? {
            guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
            return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        }
    
    func underLined(color:UIColor) -> NSAttributedString {
        return  NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue,.underlineColor:color , .foregroundColor:color])
       }
    
    var isBlank: Bool {
          return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
      }
}

extension Optional where Wrapped == String {
    var isBlank: Bool {
        if let unwrapped = self {
            return unwrapped.isBlank
        } else {
            return true
        }
    }
}
