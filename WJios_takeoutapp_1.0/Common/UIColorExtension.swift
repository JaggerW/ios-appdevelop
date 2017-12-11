//
//  UIColorExtension.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 06/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r: CGFloat,g: CGFloat, b: CGFloat){
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
}



