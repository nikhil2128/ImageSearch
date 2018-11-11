//
//  APIConfigurationUtil.swift
//  ImageSearch
//
//  Created by Nikhil Bansal on 10/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

enum CachePolicy{
    case Cache, Remote, CacheRemote, RemoteCache
}

class APIConfigurationUtil: NSObject {
    
    static func getConfiguration(_ apiType:APIType) -> APIConfiguration?{
        let path = Bundle.main.path(forResource: "APIConfiguration", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!) as? [String: Any]
        
        let key = apiType.rawValue as String
        
        let apiConfigDict = dict![key] as? [String: Any]
        
        if apiConfigDict == nil {
            return nil
        }
        
        let model = APIConfiguration(dict: apiConfigDict!)
        
        return model
    }
}

class APIConfiguration:NSObject {
    var cachePolicy:CachePolicy = .Remote
    var cacheInterval = 0
    var url = ""
    var category = ""
    var params = Array<String>()
    var isAuthHeaderRequired = false
    var paramEncodingType:encodingType = encodingType.URL
    var methodType:HttpMethodType = .get
    var isAppendUrlParams = false
    var baseUrlType = 0
    
    convenience init(dict:[String:Any]) {
        self.init()
        cacheInterval = dict["cacheInterval"] as! Int
        url = dict["url"] as! String
        category = dict["category"] as! String
        params = dict["params"] as! Array<String>
        
        isAuthHeaderRequired = dict["isAuthHeaderRequired"] as! Bool
        
        if dict["isAppendUrlParams"] != nil {
            isAppendUrlParams = dict["isAppendUrlParams"] as! Bool
        }
        
        if dict["baseUrlType"] != nil {
            baseUrlType = dict["baseUrlType"] as! Int
        }
        
        switch dict["cachePolicy"] as! String {
        case "cache":
            cachePolicy = .Cache
        case "remote":
            cachePolicy = .Remote
        case "remoteCache":
            cachePolicy = .RemoteCache
        case "cacheRemote":
            cachePolicy = .CacheRemote
        default:
            cachePolicy = .Remote
        }
        
        switch dict["EncodingType"] as! String {
        case "URL":
            paramEncodingType = .URL
        case "JSON":
            paramEncodingType = .JSON
        case "URLEncodedInURL":
            paramEncodingType = .URLEncodedInURL
        default:
            paramEncodingType = .URL
        }
        
        
        switch dict["MethodType"] as! String {
        case "GET":
            methodType = .get
        case "POST":
            methodType = .post
        case "PUT":
            methodType = .put
        case "DELETE":
            methodType = .delete
        case "PATCH":
            methodType = .patch
        case "POSTDATA":
            methodType = .postData
        default:
            methodType = .get
        }
        
    }
}
