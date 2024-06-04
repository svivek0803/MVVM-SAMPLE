//
//  UIImageView + Ext.swift
//  ExpatLand
//
//  Created by User on 02/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//


import UIKit
import UIImage_animatedGif

extension UIImageView {
    func setGifWith(name: String) {
        guard   let url = Bundle.main.url(forResource: name, withExtension: "gif"),
                let gifData = try? Data(contentsOf: url) else {return}
        
        let gifImage = UIImage.animatedImage(withAnimatedGIFData: gifData)
        animationImages = gifImage?.images
        image = gifImage?.images?.last
    }
    
}

extension UIImage {
    var jpeg: Data? { jpegData(compressionQuality: 0.5) }  // QUALITY min = 0 / max = 1
    var png: Data? { pngData() }
    
    
    public enum DataUnits: String {
           case byte, kilobyte, megabyte, gigabyte
       }

       func getSizeIn(_ type: DataUnits)-> Double {

        guard let data = self.jpegData(compressionQuality: 1) else {
            return 0.0
           }

           var size: Double = 0.0

           switch type {
           case .byte:
               size = Double(data.count)
           case .kilobyte:
               size = Double(data.count) / 1024
           case .megabyte:
               size = Double(data.count) / 1024 / 1024
           case .gigabyte:
               size = Double(data.count) / 1024 / 1024 / 1024
           }
  
     print("testing", size)
           return size
       }
}
