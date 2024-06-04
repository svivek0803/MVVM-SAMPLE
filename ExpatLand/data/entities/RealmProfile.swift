//
//  RealmProfile.swift
//  ExpatLand
//
//  Created by User on 14/01/22.
//  Copyright © 2022 cypress. All rights reserved.
//


import Foundation
import RealmSwift

class RealmProfile: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var number : String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var company: String = ""
    @objc dynamic var secondaryEmail: String = ""
    @objc dynamic var phoneNumber: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var profileImageURL: String = ""
    @objc dynamic var membershipID: Int = 0
    @objc dynamic var notificationStatus: Int = 0
    @objc dynamic var membership: RealmMembership?
    
    let expertises = List<RealmExpertise>()
    let countries = List<RealmCountry>()
    let cities = List<RealmCity>()
//    @objc dynamic var expertiseIDS: [Int] = []
//    @objc dynamic var  cityIDS: [Int] = []

    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ id: Int ,_ name: String ,_ email: String ,_ firstName: String,_ lastName: String,_ company:String,_ secondaryEmail: String ,_ phoneNumber: String ,_ title: String , _ profileImageURL: String , _ membershipID: Int, _ notificationStatus: Int ) {
        self.init()
        self.id = id
        self.name = name
        self.email = email
        self.firstName = firstName
        self.number = number
        self.lastName = lastName
        self.company = company
        self.secondaryEmail = secondaryEmail
        self.phoneNumber = phoneNumber
        self.title = title
        self.profileImageURL = profileImageURL
        self.membershipID = membershipID
        self.notificationStatus = notificationStatus
        
        
    }
}
