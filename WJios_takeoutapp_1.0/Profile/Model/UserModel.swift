//
//  UserModel.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 30/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

class UserModel: NSObject {

    @objc var userId : Int = 0
    @objc var userName : String = ""
    @objc var userPassword : String = ""
    @objc var userTel : String = ""
    @objc var userImage : String = ""
    
    init(dict: [String : NSObject]){
        super.init()
        setValuesForKeys(dict)
    }
    
    override init() {
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
