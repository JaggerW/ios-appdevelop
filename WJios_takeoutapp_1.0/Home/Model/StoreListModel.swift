//
//  StoreList.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 14/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

class StoreListModel: NSObject {
    //商铺ID
    @objc var storeId: Int = 0
    //商铺名称
    @objc var storeName: String = ""
    //商铺评分
    @objc var storeGrade: Float = 0
    //商铺月销售量
    @objc var salesAmount: Int = 0
    //商铺起送价格
    @objc var sendingPrice: Int = 0
    //运费
    @objc var deliveryCost: Float = 0
    //商铺距离
    @objc var storeDistance: Int = 0
    //商铺活动
    @objc var storeActivityTip1: String = ""
    @objc var storeActivityTip2: String = ""
    //商铺图片
    @objc var storeImage: String = ""
    //商家简介
    @objc var briefIntroduction: String = ""
    //商家公告
    @objc var storeNotice: String = ""
    //商家联系电话
    @objc var storeTel: String = ""
    //商家地址
    @objc var storeAddress: String = ""
    //商家送货时间
    @objc var sendStartTime: String = ""
    //商家停止送货时间
    @objc var sentEndTime: String = ""
    //商家营业资格
    @objc var storeQualification: String = ""
    
    init(dict: [String : NSObject]){
        super.init()
        setValuesForKeys(dict)
    }
    override init() {
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    

}
