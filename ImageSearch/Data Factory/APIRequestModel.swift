//
//  APIRequestModel.swift
//  ImageSearch
//
//  Created by Nikhil Bansal on 10/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

@objc public enum HttpMethodType:Int{
    case get, post, put, delete, patch, postData
}


enum encodingType:String{
    case URL = "URL"
    case JSON = "JSON"
    case URLEncodedInURL = "URLEncodedInURL"
}


class APIRequestModel: NSObject {
    var baseUrl:String = APIConstant.baseUrl
    var apiUrl:String!
    var parametersDict:[String:Any]?
    var httpMethodType:HttpMethodType = .get
    var encodeType:encodingType = .URL
    var isAuthHeaderRequired = false
    var isContentTypeRequired = false
    var isOtherAPI = false
    
    convenience init(apiUrl:String, parameters:[String:Any]?, httpMethodType:HttpMethodType,encoding:encodingType,isAuthHeaderRequired:Bool) {
        self.init()
        self.apiUrl = apiUrl
        self.parametersDict = parameters
        self.httpMethodType = httpMethodType
        self.encodeType = encoding
        self.isAuthHeaderRequired = isAuthHeaderRequired
    }
    
    convenience init(baseUrl: String,apiUrl:String, parameters:[String:Any]?, httpMethodType:HttpMethodType,encoding:encodingType,isAuthHeaderRequired:Bool) {
        self.init()
        self.baseUrl=baseUrl
        self.apiUrl = apiUrl
        self.parametersDict = parameters
        self.httpMethodType = httpMethodType
        self.encodeType = encoding
        self.isAuthHeaderRequired = isAuthHeaderRequired
    }
    
    convenience init(apiUrl:String, parameters:[String:Any]?, httpMethodType:HttpMethodType,encoding:encodingType,isAuthHeaderRequired:Bool,isContentTypeRequired:Bool) {
        self.init()
        self.apiUrl = apiUrl
        self.parametersDict = parameters
        self.httpMethodType = httpMethodType
        self.encodeType = encoding
        self.isAuthHeaderRequired = isAuthHeaderRequired
        self.isContentTypeRequired = isContentTypeRequired
    }

    
    
}
