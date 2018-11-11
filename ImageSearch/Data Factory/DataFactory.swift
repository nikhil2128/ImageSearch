//
//  DataFactory.swift
//  ImageSearch
//
//  Created by Nikhil Bansal on 10/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class DataFactory: NSObject {

    static func getData(_ apiType:APIType, requestParams:[String:Any]?, urlParams:[String:Any]?, model:BaseDataModel, completion:@escaping (_ error:Error?, _ model:BaseDataModel?)->Void){
        
        // get API configuration
        
        let apiConfig:APIConfiguration? = APIConfigurationUtil.getConfiguration(apiType)
        
        if apiConfig == nil {
            let error = NSError(domain: "API not supported", code: 500, userInfo: nil)
            completion(error,nil)
            return
        }
        
        getDataBasisConfiguration(apiConfig!, requestParams: requestParams, urlParams: urlParams, model: model) { (error, model) in
            
            completion(error, model)
        }
        
    }
    
    private static func getDataBasisConfiguration(_ config:APIConfiguration, requestParams:[String:Any]?, urlParams:[String:Any]?, model:BaseDataModel, completion:@escaping (_ error:Error?, _ model:BaseDataModel?)->Void){
        
        switch config.cachePolicy {
        case .Remote:
            getRemoteData(config,requestParams: requestParams, urlParams: urlParams, model: model, completion: { (response) in
                
                var error:NSError?
                
                //if !response.isSuccess {
                var errorMsg = ""
                if response.msg != nil{
                    errorMsg = response.msg!
                }
                
                var status = true
                
                if let str = response.responseDictionary["status"] as? String {
                    if str=="false"{
                        status = false
                    }
                }
                else {
                    if let str = response.responseDictionary["status"] as? Bool {
                        status = str
                    }
                }
                
                var code = -1
                if status == false{
                    code = 100
                }
                    
                error = NSError(domain: "", code: code, userInfo: [NSLocalizedDescriptionKey:errorMsg])
                //}
                completion(error, response.customModel as! BaseDataModel?)
            })
            
            
        case .Cache:
            getCacheData(config,requestParams: requestParams, urlParams: urlParams, model: model, completion: { (response) in
                
                if !response.isSuccess {
                    getRemoteData(config,requestParams: requestParams, urlParams: urlParams, model: model, completion: { (response) in
                        
                        var error:NSError?
                        
                        if !response.isSuccess {
                            var errorMsg = ""
                            if response.msg != nil{
                                errorMsg = response.msg!
                            }
                            
                            error = NSError(domain: errorMsg, code: 100, userInfo: nil)
                        }
                        completion(error, response.customModel as! BaseDataModel?)
                    })
                }else{
                    completion(nil, response.customModel as! BaseDataModel?)
                }
            })
            
        default:
            completion(nil,nil)
        }
    }
    
    private static func getRemoteData(_ config:APIConfiguration,requestParams:[String:Any]?, urlParams:[String:Any]?, model:BaseDataModel, completion:@escaping (_ model:APIResponseModel)->Void){
        
        var url = config.url
        
        if urlParams != nil {
            if config.isAppendUrlParams {
                url = "\(url)?"
                for (key, value) in urlParams! {
                    url = url + "\(key)=\(value)&"
                }
            }else{
                for (key, value) in urlParams! {
                    url = url.replacingOccurrences(of: key, with: "\(value)")
                }
            }
            
        }
        
        
        let baseUrl:String = APIConstant.baseUrl
        
        let rqstModel = APIRequestModel(baseUrl:baseUrl, apiUrl: url , parameters: requestParams, httpMethodType: config.methodType, encoding: config.paramEncodingType,isAuthHeaderRequired: config.isAuthHeaderRequired)
        
    
        APIUtil().fetchData(rqstModel) { (response) in
            var parsedModel:BaseDataModel?
            
            if (response.isSuccess){
                parsedModel = model.parseData(json: response.responseDictionary)
                
                let hash = generateHash(config, requestParams: requestParams, urlParams: urlParams)
                
                CacheUtil.saveData(config, data: response.rawResponse, identifier: hash)
            }
            response.customModel = parsedModel
            completion(response)
        }
    }
    
    
    private static func getCacheData(_ config:APIConfiguration,requestParams:[String:Any]?, urlParams:[String:Any]?, model:BaseDataModel, completion:@escaping (_ model:APIResponseModel)->Void){
        
        let hash = generateHash(config, requestParams: requestParams, urlParams: urlParams)
        
        let cacheModel = CacheUtil.getData(hash)
        
        // No cache
        if cacheModel == nil{
            let responseModel = APIResponseModel()
            responseModel.isSuccess = false
            responseModel.msg = "Cache Unavailable"
            responseModel.responseCode = CacheErrorCode.Unavailable.rawValue
            completion(responseModel)
            
            return
        }
        
        let parsedModel = model //TODO : = model.parseData(json: (cacheModel?.data)!)
        
        // invalid cache
        if (cacheModel?.isInvalidated())!{
            let responseModel = APIResponseModel()
            responseModel.isSuccess = false
            responseModel.msg = "Cache Invalidated"
            responseModel.responseCode = CacheErrorCode.InvalidData.rawValue
            responseModel.customModel = parsedModel
            
            completion(responseModel)
            
            return
        }
        
        let responseModel = APIResponseModel()
        responseModel.isSuccess = true
        responseModel.customModel = parsedModel
        
        completion(responseModel)
    }
    
    private static func generateHash(_ config:APIConfiguration,requestParams:[String:Any]?, urlParams:[String:Any]?) -> String {
        
        var hash = ""
        
        var url = config.url
        
        if urlParams != nil {
            for (key, value) in urlParams! {
                url = url.replacingOccurrences(of: key, with: "\(value)")
            }
        }
        
        var paramStr = ""
        
        if requestParams != nil {
            for param in config.params {
                if requestParams?[param] != nil {
                    paramStr = paramStr.appending("\(param)=\(String(describing: requestParams?[param]))")
                }
            }
        }

        let str = "\(url)&\(paramStr)"
        
        hash = str.toBase64()
        
        return hash
        
    }
}
