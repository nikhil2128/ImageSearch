//
//  PhotosModel.swift
//  ImageSearch
//
//  Created by Jyoti Gupta on 10/11/18.
//  Copyright © 2018 Nikhil Bansal. All rights reserved.
//

import UIKit

class PhotosModel: BaseDataModel {
    
    var photos:[PhotoModel] = []
    var total = 0
    var pages = 0
    
    override func parseData(json:[String:Any]) -> PhotosModel?{
        let photosJSON = json["photos"] as! [String:Any]
        
        
        total = Int(photosJSON["total"] as! String) ?? 0
        pages = photosJSON["pages"] as! Int
        
        if let _arr  = photosJSON["photo"] as? [[String:Any]] {
            photos = []
            for data in _arr{
                let photoModel = PhotoModel(json: data)
                photos.append(photoModel)
            }
        }
        
        return self
    }
    
    func fetchPhotos(page:Int, limit:Int, text:String, completionBlock:@escaping (_ responseObj:PhotosModel?)->Void) {
        let params = ["method":"flickr.photos.search","api_key":APIConstant.APIKey,"text":text,"safe_search":1,"per_page":limit,"page":page,"format":"json","nojsoncallback":1] as [String : Any]
        
        
        DataFactory.getData(.ImageSearch, requestParams:params, urlParams: nil, model: self) { (error, parsedModel) in
            let model = parsedModel as? PhotosModel
            completionBlock(model)
        }
    }
    
    func resetAll(){
        total = 0
        pages = 0
        photos.removeAll()
        
    }
    
    func copy(model:PhotosModel){
        self.pages = model.pages
        self.total = model.total
        
        for photo in model.photos {
            self.photos.append(photo)
        }
    }
    
    func appendPhotos(photos:[PhotoModel]){
        for photo in photos {
            self.photos.append(photo)
        }
    }
    
}
