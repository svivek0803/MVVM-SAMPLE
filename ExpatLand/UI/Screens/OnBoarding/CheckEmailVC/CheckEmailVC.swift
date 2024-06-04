//
//  CheckEmailVC.swift
//  ExpatLand
//
//  Created by User on 13/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//


import Foundation
import UIKit

//MARK:ForgotPasswordVC
//=====================
class CheckEmailVC: UIViewController {

    //MARK:IBOutlets
    //==============
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var imgLogo : UIImageView!
    @IBOutlet weak var viewFooter : UIView!
    @IBOutlet weak var stackView : UIStackView!
    @IBOutlet weak var btnSignIn : UIButton!
    @IBOutlet weak var btnBack : UIButton!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblNote : UILabel!

    
    
    //MARK:Variables
    //==============
    var emailText = String()
    
    
    //MARK:Life - Cycle
    //=================
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        // Do any additional setup after loading the view.
    }


}
//MARK:Functions
//==============
extension CheckEmailVC {
   
    private func initialSetup(){
        viewFooter.backgroundColor = Constants.Color.appDefaultColor
        btnSignIn.backgroundColor = Constants.Color.appDefaultColor
        btnSignIn.setTitle(Constants.TextConstant.backToSignIn, for: .normal)
        btnSignIn.setTitleColor(.white, for: .normal)
        btnSignIn.makeRoundCorner(2)
        lblTitle.text = Constants.TextConstant.checkEmail
        lblTitle.textColor = Constants.Color.appDefaultColor
        lblNote.text = "The link has been sent to \(emailText)"
        self.dismissKey()
    }
    
}
//MARK:IBActions
//==============
extension CheckEmailVC {
   
    @IBAction func _buttonBack(_ sender : UIButton){
        Console.log("_buttonBack")
        self.popViewController()
    }
    @IBAction func _buttonSignIn(_ sender : UIButton){
        Console.log("_buttonSignIn")
        let vc = UserSignInVC.instantiate(fromAppStoryboard: .onboarding)
        navigationController?.pushViewController(vc, animated: true)
    }
    
  
}

