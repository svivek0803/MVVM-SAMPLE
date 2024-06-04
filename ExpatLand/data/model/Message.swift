//
//  Message.swift
//  ExpatLand
//
//  Created by User on 23/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import UIKit

struct MessageSubtitle {
  static let video = "Attachment: Video"
  static let image = "Photo"
  static let file = "Attachment: File"
  static let audio = "Audio message"
 // static let empty = "No messages here yet."
  static let empty = ""
}

class Message: NSObject  {
  
    var messageUID: String?
    var isInformationMessage: Bool?

    var fromId: String?
    var text: String?
    var toId: String?
    var timestamp: NSNumber?
    var convertedTimestamp: String?
  
    var status: String?
    var seen: Bool?
      var time: String?
  
    var imageUrl: String?
    var imageHeight: NSNumber?
    var imageWidth: NSNumber?
  
    var localImage: UIImage?
  
    var localVideoUrl: String?
  
    var voiceData: Data?
    var voiceDuration: String?
    var voiceStartTime: Int?
    var voiceEncodedString: String?

    var videoUrl: String?
  
    var estimatedFrameForText:CGRect?
    var imageCellHeight: NSNumber?
  
    var senderName: String? //local only, group messages only
      
//    func chatPartnerId() -> String? {
//        return fromId == kUserDefaults.getUserId() ? toId : fromId
//    }
  
    init(dictionary: [String: AnyObject]) {
        super.init()
      
        messageUID = dictionary["messageUID"] as? String
        isInformationMessage = dictionary["isInformationMessage"] as? Bool
        fromId = dictionary["fromId"] as? String
        text = dictionary["text"] as? String
        toId = dictionary["toId"] as? String
        timestamp = dictionary["timestamp"] as? NSNumber
         time = dictionary["time"] as? String
        convertedTimestamp = dictionary["convertedTimestamp"] as? String
      
        status = dictionary["status"] as? String
        seen = dictionary["seen"] as? Bool
        
        imageUrl = dictionary["imageUrl"] as? String
        imageHeight = dictionary["imageHeight"] as? NSNumber
        imageWidth = dictionary["imageWidth"] as? NSNumber
        
        videoUrl = dictionary["videoUrl"] as? String
      
        localImage = dictionary["localImage"] as? UIImage
        localVideoUrl = dictionary["localVideoUrl"] as? String
      
        voiceEncodedString = dictionary["voiceEncodedString"] as? String
        voiceData = dictionary["voiceData"] as? Data //unused
        voiceDuration = dictionary["voiceDuration"] as? String
        voiceStartTime = dictionary["voiceStartTime"] as? Int
      
        estimatedFrameForText = dictionary["estimatedFrameForText"] as? CGRect
        imageCellHeight = dictionary["imageCellHeight"] as? NSNumber
      
        senderName = dictionary["senderName"] as? String
    }
}
