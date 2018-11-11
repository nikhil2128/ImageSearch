//
//  APIConstant.swift
//  ImageSearch
//
//  Created by Nikhil Bansal on 10/11/18.
//  Copyright © 2018 Nikhil Bansal. All rights reserved.
//

import Foundation

enum APIType:String{
    case ImageSearch
}

class APIConstant: NSObject {
    static let baseUrl:String = "https://api.flickr.com"
    static let APIKey:String = "3e7cc266ae2b0e0d78e279ce8e361736"
}
