//
//  SGImagePicker.swift
//  ExpatLand
//
//  Created by User on 23/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

//Keep strong reference


class SGImagePicker: NSObject {
    private override init() {}
    let imagePicker = UIImagePickerController()
    typealias CompletionBlock = (_ pickedImage: UIImage?)-> Void
    typealias CompletionUrl = (_ pickedUrl: URL?)-> Void
    var completion: CompletionBlock?
    var completionUrl:CompletionUrl?
    var enableEditing: Bool!
    var imageType : ImageType = .camera
    
    enum ImageType {
        case camera
        case library
        case video
    }
    
    init(enableEditing: Bool) {
        super.init()
        imagePicker.delegate = self
        imagePicker.allowsEditing = enableEditing
        self.enableEditing = enableEditing
         _ = checkPlistKeys()
    }
    
    private func checkPlistKeys() -> Bool {
        if let camera = Bundle.main.object(forInfoDictionaryKey: "NSCameraUsageDescription") as? String {
            print(camera)
        } else {
            self.showAlert(title: "Camera".localized, description: "NSCameraUsageDescription not found in Info.plist.".localized)
            print("NSCameraUsageDescription not found in Info.plist.")
            return false
        }
        
        if let library = Bundle.main.object(forInfoDictionaryKey: "NSPhotoLibraryUsageDescription") as? String {
            print(library)
        } else {
            self.showAlert(title: "Library".localized, description: "NSPhotoLibraryUsageDescription not found in Info.plist.".localized)
            print("NSPhotoLibraryUsageDescription not found in Info.plist.")
            return false
        }
        return true
    }
    
    func getImage(from: ImageType, completion: @escaping CompletionBlock) {
        self.completion = completion
        self.imageType = from
        if checkPlistKeys() {
            let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
            let rootVC = keyWindow?.rootViewController
            if from == .camera {
                if !UIImagePickerController.isSourceTypeAvailable(.camera){
                    self.showAlert(title: "Camera".localized, description: "Camera is supprted".localized)
                    return
                }
                imagePicker.sourceType = .camera
            } else if from == .library {
                if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                    self.showAlert(title: "Camera".localized, description: "PhotoLibrary is supprted".localized)
                    return
                }
                imagePicker.sourceType = .photoLibrary
                imagePicker.mediaTypes = [kUTTypeImage as String]
            }
            else
            {
                if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                    self.showAlert(title: "Camera".localized, description: "PhotoLibrary is supprted".localized)
                    return
                }
                imagePicker.sourceType = .photoLibrary
                imagePicker.mediaTypes = [kUTTypeMovie as String]
            }
            
            rootVC?.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    
    func getVideo(from: ImageType, completion: @escaping CompletionUrl) {
        self.completionUrl = completion
        self.imageType = from
        if checkPlistKeys() {
            let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
            let rootVC = keyWindow?.rootViewController
            if from == .camera {
                if !UIImagePickerController.isSourceTypeAvailable(.camera){
                    self.showAlert(title: "Camera".localized, description: "Camera is supprted".localized)
                    return
                }
                imagePicker.sourceType = .camera
            } else if from == .library {
                if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                    self.showAlert(title: "Camera".localized, description: "PhotoLibrary is supprted".localized)
                    return
                }
                imagePicker.sourceType = .photoLibrary
                imagePicker.mediaTypes = [kUTTypeImage as String]
            }
            else
            {
                if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                    self.showAlert(title: "Camera".localized, description: "PhotoLibrary is supprted".localized)
                    return
                }
                imagePicker.sourceType = .photoLibrary
                imagePicker.mediaTypes = [kUTTypeMovie as String]
            }
            
            rootVC?.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    
    private func showAlert(title: String, description: String) {
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        let rootVC = keyWindow?.rootViewController
        
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alert.addAction(okAction)
        rootVC?.present(alert, animated: true, completion: nil)
    }
    
    
}

extension SGImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if imageType != .video {
        if enableEditing {
            if let image = info[.editedImage] as? UIImage{
                completion?(image)
            } else {
                completion?(nil)
            }
        } else {
            if let image = info[.originalImage] as? UIImage{
                completion?(image)
            } else {
                completion?(nil)
            }
        }
    }
    else
    {
        if let videoURL = info[.mediaURL] as? NSURL {
            
            let url: URL = videoURL.absoluteURL!
            completionUrl?(url)
        }
        else
        {
            completionUrl?(nil)
        }
    }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
