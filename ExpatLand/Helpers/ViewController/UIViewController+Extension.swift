//
//  UIViewController+Extension.swift
//  ExpatLand
//
//  Created by User on 02/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Photos

extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    func showAlert(title: String = "", message: String)  {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: Constants.LabelText.okUpperCase.rawValue, style: .default) { (_) in
        }
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func showAlert(message: String?, title: String?,completionAfterDismiss: ( () -> () )? = nil,alertActions: [UIAlertAction]? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let alertActions = alertActions {
            alertActions.forEach({ alertController.addAction($0) })
        }
        else {
            let action = UIAlertAction(title: Constants.LabelText.localizedString(.okUpperCase), style: .cancel) { (alert) in
                completionAfterDismiss?()
            }
            
            alertController.addAction(action)
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func showSettingAlert(title: String = "Expatland", message: String)  {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let settingAction = UIAlertAction(title: Constants.LabelText.goToSettings.rawValue, style: .default) { (_) in
            //Redirect to Settings app
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        }
        let cancelAction = UIAlertAction(title: Constants.LabelText.cancel.rawValue, style: .default) { (_) in
        }
        alertController.addAction(settingAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func delay(time:TimeInterval,completionHandler: @escaping ()->()) {
        let when = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: when) {
            completionHandler()
        }
    }
    func setLeftBarButtonItem(imageName: String){
        let image =  UIImage.init(named: imageName)?.withRenderingMode(.alwaysOriginal)
        let barButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    func setRightBarButtonItem(imageName: String){
        let image =  UIImage.init(named: imageName)?.withRenderingMode(.alwaysOriginal)
        let barButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = barButtonItem
        //navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    
    func setNavigation(_ title: String) {
        navigationItem.title = title
        
    }
    
    func setRightBarButtonItem(title: String){
        let barButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: nil)
        barButtonItem.tintColor = .white
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    func setCentreBarItem(title: String){
        let label = UILabel()
        label.text = title
        label.contentMode = .scaleAspectFit
        navigationItem.titleView = label
    }
    
 

    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
    
    
    func dismissKey()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func checkCameraAccess()->Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
           return false
        case .restricted:
            return false
        case .authorized:
           return true
        case .notDetermined:
            return true
        @unknown default:
            return false
        }
    }
    
   

}



extension UINavigationController{
    
    func setBottomShadow(){
        navigationBar.layer.masksToBounds = false
        navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        navigationBar.layer.shadowOpacity = 0.8
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navigationBar.layer.shadowRadius = 10
    }
    func available(viewController: AnyClass)-> UIViewController?{
        for vc in viewControllers {
            if vc.isKind(of: viewController)  {
                return vc
            }
            
        }
        return nil
    }
    func containsViewController(ofKind kind: AnyClass) -> Bool{
        return self.viewControllers.contains(where: { $0.isKind(of: kind) })
    }
    
}
class DynamicHeightCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}


extension UIApplication {
  class func topViewController(controller: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
    if let navigationController = controller as? UINavigationController {
      return topViewController(controller: navigationController.visibleViewController)
    }
    if let tabController = controller as? UITabBarController {
      if let selected = tabController.selectedViewController {
        return topViewController(controller: selected)
      }
    }
    if let presented = controller?.presentedViewController {
      return topViewController(controller: presented)
    }
    return controller
  }
    
    class  func dismissAnyAlertControllerIfPresent() {
        guard let window :UIWindow = UIApplication.shared.windows.first , var topVC = window.rootViewController?.presentedViewController else {return}
        while topVC.presentedViewController != nil  {
            topVC = topVC.presentedViewController!
        }
        if topVC.isKind(of: UIAlertController.self) {
            topVC.dismiss(animated: false, completion: nil)
        }
    }
}
