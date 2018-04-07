//
//  OrderModel.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 21/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

class OrderModel: NSObject {
    //懒加载属性
    lazy var goodsList : [GoodsModel] = [GoodsModel]()
    //lazy var orderGoodsList : [OrderGoodsModel] = [OrderGoodsModel]()

    //订单状态标识符。0：配送中，1：订单完成， 2：订单被取消
    @objc var orderStatus : Int = 0
    
    //评论标识 0: 可以评论  1：已经评论过不能评论
    @objc var commentFlag : Int = 0
    
    //订单号
    @objc var orderId : String = ""
    
    //用户ID
    @objc var userId : Int = 0
    
    //商家号
    @objc var storeId : Int = 0
    
    //商家名称
    @objc var storeName : String = ""
    
    //下单时间
    @objc var orderTime : String = ""
    
    //送达时间
    @objc var arriveTime : String?
    
    //收货地址
    @objc var address : String = ""
    
    //配送方式
    @objc var deliverySide : String = ""
    
    //支付方式
    @objc var payWay : String = ""
    
    //配送费
    @objc var deliveryCost : Float = 0
    
    //优惠
    @objc var preferentialPrice : Float = 0
    
    //总支付金额
    @objc var payCost : Float = 0
    
    //订单商品列表
    @objc var goods : [[String : NSObject]]?{
        didSet{
            guard let goods = goods else {return}
                print("对订单商品赋值")
                for dict in goods{
                    goodsList.append(GoodsModel(dict: dict))
                }
        }
    }
    
    init(dict: [String : NSObject]){
        super.init()
        setValuesForKeys(dict)
    }
    override init() {
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
}
