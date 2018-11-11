//
//  NSNumberExtension.swift
//  ImageSearch
//
//  Created by hitesh on 29/12/16.
//  Copyright © 2018 GoldVip Technology Solutions Pvt. Ldt. All rights reserved.
//

import Foundation

extension NSNumber {
    var isBool: Bool { return CFBooleanGetTypeID() == CFGetTypeID(self) }
}

