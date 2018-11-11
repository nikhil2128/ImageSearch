//
//  CacheDataModel.swift
//  ImageSearch
//
//  Created by Nikhil Bansal on 07/10/16.
//  Copyright © 2018 GoldVIP Technology Solutions Private Limited. All rights reserved.
//

import UIKit

class CacheDataModel: NSObject, NSCopying {
    var identifier:String = ""  // hash
    var data:String?  // JSON
    var category:String = ""
    var cacheInterval = 0
    var isValid: Bool = true
    var cacheTime:Date = Date()
 
    
    public func copy(with zone: NSZone? = nil) -> Any {
        let model = CacheDataModel()
        model.identifier = self.identifier
        model.data = self.data
        model.category = self.category
        model.cacheInterval = self.cacheInterval
        model.isValid = self.isValid
        model.cacheTime = self.cacheTime
        
        return model
    }
    
    
    //MARK: Public Methods
    
    func isInvalidated() -> Bool{
        //TODO : Logic to check if cache data is invalidated
        return true
    }
    
    func save(){
        
        //TODO : Logic to cache data
    }
}
