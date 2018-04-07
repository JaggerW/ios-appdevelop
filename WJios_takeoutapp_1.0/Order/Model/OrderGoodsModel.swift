//
//  OrderGoodsModel.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 23/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

class OrderGoodsModel: NSObject {

    
    @objc var orderGoodsId: Int = 0
    @objc var goodsName: String = ""
    @objc var goodsPrice: Float = 0
    @objc var goodsCount: Int = 0
    @objc var goodsImage:String = ""
    @objc var orderId: String = ""
    
    init(dict: [String : NSObject]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
