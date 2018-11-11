//
//  SavedDataUtils.swift
//  ImageSearch
//
//  Created by Nikhil Bansal on 03/06/16.
//  Copyright © 2018 Nikhil Bansal. All rights reserved.
//

import UIKit

class SavedDataUtils: NSObject {
    /// save user info in local db
    
    static func saveValue(key:String, value:String){
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    static func getValue(key:String) -> String?{
        let userDefaults = UserDefaults.standard
        let userID = userDefaults.object(forKey: key) as? String
        
        return userID
    }

}
