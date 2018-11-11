//
//  PhotoModel.swift
//  ImageSearch
//
//  Created by Jyoti Gupta on 10/11/18.
//  Copyright © 2018 Nikhil Bansal. All rights reserved.
//

import UIKit

class PhotoModel: BaseDataModel {
    var farm = 0
    var id:String?
    var isfamily = 0
    var isfriend = 0
    var ispublic = 1
    var owner:String?
    var secret:String?
    var server:String?
    var title:String?
    
    var imgUrl:String?
    
    convenience init(json:[String:Any]) {
        self.init()
        
        farm = json["farm"] as! Int
        id = json["id"] as? String
        isfamily = json["isfamily"] as! Int
        isfriend = json["isfriend"] as! Int
        ispublic = json["ispublic"] as! Int
        owner = json["owner"] as? String
        secret = json["secret"] as? String
        server = json["server"] as? String
        title = json["title"] as? String
        
    }
    
    func formatImgUrl(){        
        imgUrl = "http://farm\(farm).static.flickr.com/\(server!)/\(id!)_\(secret!).jpg"
    }
}
