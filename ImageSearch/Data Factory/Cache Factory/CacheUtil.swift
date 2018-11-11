//
//  CacheUtil.swift
//  ImageSearch
//
//  Created by Nikhil Bansal on 05/10/16.
//  Copyright © 2018 GoldVIP Technology Solutions Private Limited. All rights reserved.
//

import UIKit

enum CacheErrorCode:Int {
    case Unavailable = 100, InvalidData = 200
}

class CacheUtil: NSObject {
    
    static func saveData(_ config:APIConfiguration, data:String, identifier:String){
        let cacheModel = CacheDataModel()
        
        cacheModel.identifier = identifier
        cacheModel.cacheInterval = config.cacheInterval
        cacheModel.category = config.category
        cacheModel.data = data
        cacheModel.save()
    }
    
    static func getData(_ identifier:String) -> CacheDataModel? {
        var cacheModel:CacheDataModel?
        
        // TODO: logic to return data from cache
        
        return cacheModel
    }
}
