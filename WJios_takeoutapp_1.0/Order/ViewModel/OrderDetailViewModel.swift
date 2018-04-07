//
//  OrderDetailViewModel.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 23/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

class OrderDetailViewModel: NSObject {

    lazy var orderModel = OrderModel()
}

extension OrderDetailViewModel{
    
    func requestData(parameters: String,finishedCallback : @escaping () ->()){
        print("开始请求数据")
            NetworkTools.requestData(type: .GET, URLString: "http://127.0.0.1:8080/myapp/getorder", parameters: ["orderId" : parameters ], finishedCallback: { (result) in
                guard let resultDict = result as? [String : NSObject] else {return}
                //获取数组
                guard let dict = resultDict["data"] as? [String : NSObject] else {return}
                //遍历数组，获取字典并转成数组
                self.orderModel = OrderModel(dict: dict)
                print(self.orderModel.address)
                print("订单详情数据请求完毕")
                finishedCallback()
            })
        
    }
}

