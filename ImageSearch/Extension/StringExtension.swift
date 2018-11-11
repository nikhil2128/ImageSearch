//
//  StringExtension.swift
//  ImageSearch
//
//  Created by hitesh on 29/12/16.
//  Copyright © 2018 GoldVip Technology Solutions Pvt. Ldt. All rights reserved.
//

import Foundation

extension String{
    func isValid() -> Bool {
        if self.isEmpty{
            return false
        }
        else{
            return true
        }
    }
    
    func toBool() -> Bool {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return false
        }
    }
    
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func toBase64()->String{
        
        let data:Data = self.data(using: String.Encoding.utf8)!
        
        return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
    }
}

