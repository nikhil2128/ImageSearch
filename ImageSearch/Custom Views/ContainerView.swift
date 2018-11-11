//
//  ContainerView.swift
//  ImageSearch
//
//  Created by Nikhil Bansal on 10/11/18.
//  Copyright © 2018 Nikhil Bansal. All rights reserved.
//

import UIKit

class ContainerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customise()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customise()
    }
    
    //MARK: Private Methods
    
    private func customise(){
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 1
        self.layer.borderColor = ColorConstant.Primary.cgColor
        self.layer.cornerRadius = 5
    }
}
