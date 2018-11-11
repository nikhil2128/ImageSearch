//
//  UIImageviewExtension.swift
//  ImageSearch
//
//  Created by Jyoti Gupta on 10/11/18.
//  Copyright © 2018 Nikhil Bansal. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setImageFromUrl(_ url: String, defaultImage: UIImage?) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        }).resume()
    }
    
}
