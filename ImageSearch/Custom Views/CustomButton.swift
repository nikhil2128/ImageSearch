//
//  CustomButton.swift
//  ImageSearch
//
//  Created by Nikhil Bansal on 10/11/18.
//  Copyright © 2018 Nikhil Bansal. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

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
        self.backgroundColor = ColorConstant.Primary
        self.setTitleColor(ColorConstant.Primary, for: .normal)
        self.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 15)
        self.layer.cornerRadius = 5
    }

}
