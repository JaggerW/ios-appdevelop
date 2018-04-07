//
//  AddressModel.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 27/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

class AddressModel: NSObject {

    
    @objc var addressId: Int = 0
    @objc var userId: Int = 0
    @objc var userName: String = ""
    @objc var address: String = ""
    @objc var userTel: String = ""
    
    init(dict:[String : NSObject]){
        super.init()
        setValuesForKeys(dict)
    }
    
    override init() {
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    func toString() -> String{
        return (address + "\n" + userName + "\t" + userTel)
    }
}
