//
//  ImageCell.swift
//  ImageSearch
//
//  Created by Jyoti Gupta on 10/11/18.
//  Copyright © 2018 Nikhil Bansal. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    func displayData(img:UIImage){
        imgView.image = img
    }
}
