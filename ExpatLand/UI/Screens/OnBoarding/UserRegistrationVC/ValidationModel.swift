//
//  ValidationModel.swift
//  ExpatLand
//
//  Created by User on 09/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation


enum ValidationError  {
   
    case email
    case password
    case name
    case lastName
    case company
    case country
    case city
    case expertise
    case secondaryEmail
    case agreement
    case newPassword
    case confirmPassword
    case passwordMismatch
    
    
}


struct ValidationModel {
    var fieldType: ValidationError = .email
    var errorString : String = Validation.errorEmptyTextFeild
 
    init(fieldType:ValidationError,errorString:String) {
        self.fieldType = fieldType
        self.errorString = errorString
    }
}
