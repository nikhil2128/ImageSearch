//
//  PhotosViewModel.swift
//  ImageSearch
//
//  Created by Jyoti Gupta on 10/11/18.
//  Copyright © 2018 Nikhil Bansal. All rights reserved.
//

import UIKit

class PhotosViewModel: NSObject {
    var photosModel = PhotosModel()
    var page = 1
    var limit = 10
    var searchText = ""
    
    var isFetchingData = false
    
    let imageCache = NSCache<NSString, UIImage>()
    
    func searchPhotos(text:String, completionBlock:@escaping (_ photos:[PhotoModel]?)->Void) {
        
        isFetchingData = true
        
        resetAll()
        
        searchText = text
        
        weak var weakSelf = self
        
        let model = PhotosModel()
        
        model.fetchPhotos(page: page, limit: limit, text: searchText) { (photosModel) in
            weakSelf?.isFetchingData = false
            
            if photosModel != nil {
                weakSelf?.formatPhotoUrl(photos: (photosModel?.photos)!)
                weakSelf?.photosModel.copy(model: photosModel!)
                completionBlock(photosModel?.photos)
            }else{
                completionBlock(nil)
            }
        }
    }
    
    func loadNextPage(_ completionBlock:@escaping (_ photos:[PhotoModel]?)->Void){
        if page == photosModel.pages {
            completionBlock(nil)
            return
        }
        
        isFetchingData = true
        page += 1
        
        weak var weakSelf = self
        
        let model = PhotosModel()
        
        model.fetchPhotos(page: page, limit: limit, text: searchText) { (photosModel) in
            
            if photosModel != nil {
                weakSelf?.formatPhotoUrl(photos: (photosModel?.photos)!)
                weakSelf?.photosModel.appendPhotos(photos: (photosModel?.photos)!)
                completionBlock(photosModel?.photos)
            }else{
                completionBlock(nil)
            }
            
            //weakSelf?.isFetchingData = false
        }
    }
    
    private func resetAll(){
        page = 1
        searchText = ""
        imageCache.removeAllObjects()
        photosModel.resetAll()
    }
    
    private func formatPhotoUrl(photos:[PhotoModel]){
        for photo in photos {
            photo.formatImgUrl()
        }
    }
    
    func downloadImageFromUrl(_ urlStr: String, row:Int,completionBlock:@escaping (_ img:UIImage?, _ row:Int)->Void) {
        
        if let cachedImage = imageCache.object(forKey: urlStr as NSString) {
            //print("Cache \(row)")
            completionBlock(cachedImage,row)
            return
        }
        
        guard let url = URL(string: urlStr) else {
            completionBlock(nil,row)
            return
        }
        weak var weakSelf = self
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    DispatchQueue.main.async {
                        completionBlock(nil,row)
                    }
                    return
            }
            weakSelf?.imageCache.setObject(image, forKey: urlStr as NSString)
            DispatchQueue.main.async {
                completionBlock(image,row)
            }
            
        }).resume()
    }
    
}
