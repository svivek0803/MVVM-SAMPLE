//
//  UITextField+Extension.swift
//  ExpatLand
//
//  Created by User on 02/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//


import Foundation
import UIKit

extension UITextField {
    
    enum Direction {
        case Left
        case Right
    }
    
    // add image to textfield
    func withImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor, backColor: UIColor){
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        mainView.layer.cornerRadius = 5
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        view.backgroundColor = backColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = CGFloat(0.5)
        view.layer.borderColor = colorBorder.cgColor
        mainView.addSubview(view)
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 5.0, y: 8.0, width: 20.0, height: 20.0)
        imageView.backgroundColor = .clear

        view.addSubview(imageView)
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = colorSeparator
        mainView.addSubview(seperatorView)
        
        if(Direction.Left == direction){ // image left
            seperatorView.frame = CGRect(x: 45, y: 0, width: 5, height: 45)
            self.leftViewMode = .always
            self.leftView = mainView
        } else { // image right
            seperatorView.frame = CGRect(x: 0, y: 0, width: 5, height: 45)
            self.rightViewMode = .always
            self.rightView = mainView
        }
        
        self.layer.borderColor = colorBorder.cgColor
        self.layer.borderWidth = CGFloat(0.5)
        self.layer.cornerRadius = 5
    }
    func setRightView(imageName: String){
        let image = UIImage.init(named: imageName)
        let view = UIView.init(frame: CGRect(x: 0,y:0,width: 20,height: 20))
        view.isUserInteractionEnabled = false
        let imageView = UIImageView.init(frame: CGRect(x: 0,y:0,width: 20,height: 20))
        view.addSubview(imageView)
        imageView.center = view.center
        imageView.image = image
        self.rightView = view
        //view.backgroundColor = .green
        //imageView.backgroundColor = .red
        imageView.contentMode = .center
        self.rightViewMode = .always
    }
    func setLeftViewImage(img: UIImage) {
        let tfLeftView = UIView()
        let imageView = UIImageView();
        if UIDevice.current.userInterfaceIdiom == .pad {
            tfLeftView.frame = CGRect(x: 20, y: 22, width: 40, height: 25)
            imageView.frame = CGRect(x: 15, y: 0, width: 25, height: 25)
            tfLeftView.addSubview(imageView)
            imageView.contentMode = .scaleAspectFit
        }
        else {
            tfLeftView.frame = CGRect(x: 8, y: 5, width: 40, height: 40)
            tfLeftView.addSubview(imageView)
            imageView.frame = tfLeftView.bounds
            imageView.contentMode = .center
        }
        imageView.image = img;
        leftView = tfLeftView
        leftViewMode = .always
    }
    
    
    func applyLeftPadding(padding: Int) {
        let paddingView = UIView.init(frame: CGRect(x: 0,y:0,width: padding,height: Int(self.frame.size.height)))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightViewPassword(imageName: String){
        let image = UIImage.init(named: imageName)
        let view = UIView.init(frame: CGRect(x: 0,y:0,width: Int(self.frame.size.height),height: Int(self.frame.size.height)))
        let imageView = UIImageView.init(frame: CGRect(x: 0,y:0,width: Int(self.frame.size.height / 2),height: Int(self.frame.size.height/2)))
        view.addSubview(imageView)
        imageView.center = view.center
        imageView.isUserInteractionEnabled = true
        imageView.image = image
        self.rightView = view
        imageView.contentMode = .center
        self.rightViewMode = .always
    }
    func setRightViewImage(imageName: String){
        let image = UIImage.init(named: imageName)
        let view = UIView.init(frame: CGRect(x: 0,y:0,width: Int(self.frame.size.height),height: Int(self.frame.size.height)))
        let imageView = UIImageView.init(frame: CGRect(x: 0,y:0,width: Int(self.frame.size.height / 2),height: Int(self.frame.size.height/2)))
        view.addSubview(imageView)
        imageView.center = view.center
        imageView.image = image
        self.rightView = view
        //rightView?.backgroundColor = .green
        //imageView.backgroundColor = .red
        imageView.contentMode = .center
        self.rightViewMode = .always
        imageView.isUserInteractionEnabled = false
        view.isUserInteractionEnabled = false
    }
    
    func hasError()->Bool
    {
        if(layer.borderWidth == 1) && (layer.borderColor == Constants.Color.appDefaultErrorColor.cgColor)
        {
            return true
        }
        return false
    }
}


private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
               return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.prefix(maxLength).description
    }
}
