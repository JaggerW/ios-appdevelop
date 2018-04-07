//
//  NSDateExtension.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 21/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import Foundation

extension NSDate{
    class func getCurrentTime() -> Int {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return interval
    }
}




