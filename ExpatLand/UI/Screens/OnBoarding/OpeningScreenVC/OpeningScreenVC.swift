//
//  OpeningScreenVC.swift
//  ExpatLand
//
//  Created by User on 02/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import UIKit

//MARK:OpeningScreenVC
//=================
class OpeningScreenVC: UIViewController {

    //MARK:IBOutlets
    //==============
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var imgLogo : UIImageView!
    @IBOutlet weak var imgMap : UIImageView!
    @IBOutlet weak var viewHeader : UIView!
    @IBOutlet weak var viewFooter : UIView!
    @IBOutlet weak var stackView : UIStackView!
    @IBOutlet weak var btnSignIn : UIButton!
    @IBOutlet weak var btnRegister : UIButton!

    
    
    //MARK:Variables
    //==============
    
    
    
    //MARK:Life - Cycle
    //================
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        // Do any additional setup after loading the view.
    }


}
//MARK:Functions
//==============
extension OpeningScreenVC {
   
    private func initialSetup(){
       
        viewHeader.backgroundColor = Constants.Color.appDefaultColor
        viewFooter.backgroundColor = Constants.Color.appDefaultColor
        btnSignIn.backgroundColor = Constants.Color.appDefaultColor
      //  btnSignIn.setTitle("Sign in", for: .normal)
        btnSignIn.setTitleColor(.white, for: .normal)
        btnSignIn.makeRoundCorner(2)
       // btnRegister.setTitle("Register", for: .normal)
        btnRegister.makeBorder(1, color: Constants.Color.appDefaultColor)
        btnRegister.makeRoundCorner(2)
        btnRegister.setTitleColor(Constants.Color.appDefaultColor, for: .normal)

    }
    
}
//MARK:IBActions
//==============
extension OpeningScreenVC {
   
    @IBAction func _buttonSignIn(_ sender : UIButton){
        Console.log("_buttonSignIn")
        let vc = UserSignInVC.instantiate(fromAppStoryboard: .onboarding)
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func _buttonRegister(_ sender : UIButton){
        Console.log("_buttonRegister")
        let vc = UserRegistrationVC.instantiate(fromAppStoryboard: .onboarding)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
