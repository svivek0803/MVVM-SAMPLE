//
//  ImagePickerHelper.swift
//  ExpatLand
//
//  Created by Mac on 28/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//


var pickerCallBack:PickerImage = nil
typealias PickerImage = ((UIImage?) -> (Void))?

import UIKit
import MobileCoreServices
import AVFoundation
import Photos

class ImagePickerHelper: NSObject {
    
    private override init() {
    }
    
    static var shared : ImagePickerHelper = ImagePickerHelper()
    var picker = UIImagePickerController()
    
    // MARK:- Action Sheet
    
    func showActionSheet(withTitle title: String?, withAlertMessage message: String?, withOptions options: [String], handler:@escaping (_ selectedIndex: Int) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for strAction in options {
            let anyAction =  UIAlertAction(title: strAction, style: .default){ (action) -> Void in
                return handler(options.firstIndex(of: strAction)!)
            }
            alert.addAction(anyAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ (action) -> Void in
            return handler(-1)
        }
        alert.addAction(cancelAction)
        presetImagePicker(pickerVC: alert)
        
    }
    
    // MARK: Public Method
    
    /**
     
     * Public Method for showing ImagePicker Controlller simply get Image
     * Get Image Object
     */
    
    func showPickerController(  handler: PickerImage) {
        
        self.showActionSheet(withTitle: "Choose Option", withAlertMessage: nil, withOptions: ["Open Gallery"]){ ( _ selectedIndex: Int) in
            switch selectedIndex {
           
            case OpenMediaType.photoLibrary.rawValue:
                self.openGallery()
            
             //   let photos =  PHPhotoLibrary.authorizationStatus()
            //uncomment it for wants permission for allow and deny
            
            /*
                       PHPhotoLibrary.requestAuthorization({status in
                           if status == .authorized{
                            DispatchQueue.main.async {
                                self.openGallery()
                            }
                          
                           } else {
                            DispatchQueue.main.async {
                                self.showAlert(message:Constants.AlertMessage.localizedString(.photoLibraryPermissionText) , title: Constants.AlertMessage.localizedString(.permissionDenied), completionAfterDismiss: {
                                    
                                })
                            }
                           }
                       })
        */
            default:
                print("Default case")
            }
        }
        pickerCallBack = handler
    }
    
    
    // MARK:-  Camera
    func showCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
           // picker.allowsEditing = true
            picker.delegate = self
            picker.sourceType = .camera
            presetImagePicker(pickerVC: picker)
        } else {
            DispatchQueue.main.async{
                
                self.showAlert(title: "ExpatLand", message: "Camera not available.")
                    }
    }
        picker.delegate = self
        
    }
    
    func showAlert(title: String, message: String)  {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: Constants.LabelText.okUpperCase.rawValue, style: .default) { (_) in
        }
        alertController.addAction(confirmAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(message: String?, title: String?,completionAfterDismiss: ( () -> () )?  ,alertActions: [UIAlertAction]? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
       
            let action = UIAlertAction(title: Constants.LabelText.localizedString(.goToSettings), style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
                UIApplication.shared.open(NSURL(string:UIApplication.openSettingsURLString)! as URL, options: [:], completionHandler: nil)

                    })
            
        let actionCancel = UIAlertAction(title: Constants.LabelText.localizedString(.cancel), style: .cancel) { (alert) in
                completionAfterDismiss?()
            }
            alertController.addAction(action)
            alertController.addAction(actionCancel)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }

    // MARK:-  Gallery
    
    func openGallery() {
      //  picker.allowsEditing = true
        picker.sourceType = .savedPhotosAlbum
        presetImagePicker(pickerVC: picker)
        picker.delegate = self
    }
    
    func galleryVideo()
    {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {

            //let videoPicker = UIImagePickerController()
            
            picker.sourceType = .photoLibrary
            picker.mediaTypes = [kUTTypeMovie as String]
            presetImagePicker(pickerVC: picker)
            picker.delegate = self
            //self.present(videoPicker, animated: true, completion: nil)
        }
        picker.delegate = self
    }
    
    // MARK:- Show ViewController
    
    private func presetImagePicker(pickerVC: UIViewController) -> Void {
       // let appDelegate = UIApplication.shared.delegate as! AppDelegate
         UIApplication.shared.windows.first?.rootViewController?.present(pickerVC, animated: true, completion: {
            self.picker.delegate = self
        })
    }
    
    fileprivate func dismissViewController() -> Void {
      //  let appDelegate = UIApplication.shared.delegate as! AppDelegate
         UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK;- func for imageView in swift
    func SaveImage (imageView :UIImage) {
        UIImageWriteToSavedPhotosAlbum(imageView, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error != nil {
            
            self.showAlert(title: "ExpatLand", message: "Photos not Saved ")
        } else {
            self.showAlert(title: "ExpatLand", message: "Your altered image has been saved to your photos. ")
        }
    }
}


// MARK: - Picker Delegate
extension ImagePickerHelper : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey  : Any]) {
      guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        pickerCallBack?(image)
        dismissViewController()
    }
    
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismissViewController()
    }
}



class TextFieldMargin: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
protocol UIDocumentPickerExtendedDelegate {
    func docPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL)
}

//require UINavigationControllerDelegate also (already installed in above extension)
extension UIViewController: UIDocumentPickerDelegate {
    func openDocumentPicker(_ documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        self.present(documentPicker, animated: true, completion: {
            documentPicker.delegate = self
        })
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        controller.dismiss(animated: true, completion: nil)
        guard let viewC = self as? UIDocumentPickerExtendedDelegate else { return }
        viewC.docPicker(controller, didPickDocumentAt: url)
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
extension UITableViewCell: UIDocumentPickerDelegate {
    func openDocumentPicker(_ documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        UIApplication.shared.windows.first?.rootViewController?.present(documentPicker,animated: true,completion: {
             documentPicker.delegate = self
        })
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        controller.dismiss(animated: true, completion: nil)
        guard let viewC = self as? UIDocumentPickerExtendedDelegate else { return }
        viewC.docPicker(controller, didPickDocumentAt: url)
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
enum OpenMediaType: Int {
    case photoLibrary
}
