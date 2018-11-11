//
//  APIResponseModel.swift
//  ImageSearch
//
//  Created by Nikhil Bansal on 10/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit


class APIResponseModel: BaseDataModel {
    var customModel:AnyObject!
    var responseDictionary:[String : AnyObject] = [String : AnyObject]()
    var responseCode:Int!
    var rawResponse:String = ""
    var isSuccess:Bool = false
    var msg:String?
}
