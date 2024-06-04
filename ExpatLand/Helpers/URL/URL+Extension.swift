//
//  URL+Extension.swift
//  ExpatLand
//
//  Created by User on 06/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import MobileCoreServices

extension URL {
    
    // returns an absolute URL to the desired file in documents folder
    static func inDocumentsFolder(fileName: String) -> URL {
        return URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0], isDirectory: true)
            .appendingPathComponent(fileName)
    }
    
    func mimeType() -> String {
            let pathExtension = self.pathExtension
            if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
                if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                    return mimetype as String
                }
            }
            return "application/octet-stream"
        }
        var containsImage: Bool {
            let mimeType = self.mimeType()
            guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
                return false
            }
            return UTTypeConformsTo(uti, kUTTypeImage)
        }
        var containsAudio: Bool {
            let mimeType = self.mimeType()
            guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
                return false
            }
            return UTTypeConformsTo(uti, kUTTypeAudio)
        }
        var containsVideo: Bool {
            let mimeType = self.mimeType()
            guard  let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
                return false
            }
            return UTTypeConformsTo(uti, kUTTypeMovie)
        }
    
   func sizePerMB() -> Double {
        do {
            let attribute = try FileManager.default.attributesOfItem(atPath: self.path)
            if let size = attribute[FileAttributeKey.size] as? NSNumber {
                return size.doubleValue / 1000000.0
            }
        } catch {
            print("Error: \(error)")
        }
        return 0.0
    }
}
