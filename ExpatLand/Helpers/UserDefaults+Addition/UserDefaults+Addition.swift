//
//  UserDefaults+Addition.swift
//  ExpatLand
//
//  Created by User on 14/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func isLoggedIn()->Bool {
        return bool(forKey: UserDefaultKeys.isLoggedIn)
    }
    
    func getTokenType() -> String {
        return String.getString(string(forKey: UserDefaultKeys.tokenType))
    }
    
    func getAccessToken() -> String {
        return String.getString(string(forKey: UserDefaultKeys.accessToken))
    }
    
    func getUserId() -> Int {
        return integer(forKey: UserDefaultKeys.userId)
    }
    
    func getNotificationStatus() -> Int {
        return integer(forKey: UserDefaultKeys.notificationStatus)
    }
    
    func getDeviceToken() -> Data? {
        return data(forKey: UserDefaultKeys.notificationToken) 
    }
    
    func resetDefaults() {
        
        let dictionary = Constants.userDefaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            Constants.userDefaults.removeObject(forKey: key)
        }
    }
    
}
