//
//  GoodsModel.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 17/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

class GoodsModel: NSObject {

    @objc var goodsId: Int = 0
    @objc var goodsName: String = ""
    @objc var goodsPrice: Float = 0
    @objc var goodsSalesAmount: Int = 0
    @objc var goodsImage:String = ""
    @objc var orderId: String = ""
    @objc var goodsCount: Int = 0{
        didSet{
            orderCount = goodsCount
        }
    }
    var orderCount: Int = 0
    var section : Int = 0
    var row : Int = 0
    init(dict: [String : NSObject]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
