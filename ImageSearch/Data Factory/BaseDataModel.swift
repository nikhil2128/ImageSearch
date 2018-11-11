//
//  BaseDataModel.swift
//  ImageSearch
//
//  Created by Nikhil Bansal on 10/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class BaseDataModel: NSObject {
    
    var errorMessage = ""
    
    
    override init(){
        
    }
    
    func parseData(json:[String:Any]) -> BaseDataModel?{
        return self
    }
}
