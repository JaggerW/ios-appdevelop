//
//  GoodsGroup.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 17/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

class GoodsGroup: NSObject {
    
    
    lazy var goods : [GoodsModel] = [GoodsModel]()

    @objc var goodslist : [[String : NSObject]]?{
        didSet{
            guard let goodslist = goodslist else {return}
            for dict in goodslist{
                goods.append(GoodsModel(dict: dict))
            }
        }
    }
    @objc var categoryName : String = ""
    
    
    init(dict: [String : NSObject]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
