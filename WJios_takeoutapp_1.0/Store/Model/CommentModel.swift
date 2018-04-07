//
//  CommentModel.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 03/04/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

class CommentModel: NSObject {
    
    @objc var commentId : Int = 0
    
    @objc var storeId : Int = 0
    
    @objc var storeName : String = ""
    
    @objc var goodsName : String = ""
    
    @objc var comments : String = ""
    
    @objc var userId : Int = 0
    
    @objc var userName : String = ""
    
    @objc var commitTime : String = ""
    
    @objc var userImage : String = ""
    
    init(dict : [String : NSObject]){
        super.init()
        setValuesForKeys(dict)
    }
    
    override init() {
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
