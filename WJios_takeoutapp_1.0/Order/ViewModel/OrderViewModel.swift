//
//  OrderViewModel.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 22/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

class OrderViewModel{

    lazy var orderList : [OrderModel] = [OrderModel]()
}

//MARK:- 发送网络请求
extension OrderViewModel{
    func submitData(dict : [String : NSObject],finishedCallback : @escaping (_ flag : Bool) -> ()){
        NetworkTools.submitData(type: .POST, URLString: "http://127.0.0.1:8080/myapp/addorder", parameters: dict) { (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            let flag : Bool = (resultDict["success"] != nil)
            print("数据提交完毕")
            finishedCallback(flag)
        }
        
    }
    
    func updateData(dict : [String : NSObject],finishedCallback : @escaping (_ flag : Bool) -> ()){
        NetworkTools.submitData(type: .POST, URLString: "http://127.0.0.1:8080/myapp/modifyorder", parameters: dict) { (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            let flag : Bool = (resultDict["success"] != nil)
            print("数据修改完毕")
            finishedCallback(flag)
        }
    }
    
    func updateFlag(orderId : String ,finishedCallback : @escaping (_ flag : Bool) -> ()){
        NetworkTools.requestData(type: .POST, URLString: "http://127.0.0.1:8080/myapp/updateorderflag", parameters: ["orderId" : orderId]) { (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            let flag : Bool = (resultDict["success"] != nil)
            print("数据修改完毕")
            finishedCallback(flag)
        }
    }
    
    func requestData(userId : Int , finishedCallback : @escaping () -> ()){
        print("开始请求数据")
        NetworkTools.requestData(type: .GET, URLString: "http://127.0.0.1:8080/myapp/listorder", parameters: ["userId" : "\(userId)"]) { (result) in
            self.orderList.removeAll()
            guard let resultDict = result as? [String : NSObject] else {return}
            //获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            //遍历数组，获取字典并转成数组
            for dict in dataArray{
                let order = OrderModel(dict: dict)
                self.orderList.append(order)
            }
            print("订单列表数据请求完毕")
            finishedCallback()
        }
    }
    
    func deleteData(orderId : String , finishedCallback : @escaping (_ flag : Bool) -> ()){
        NetworkTools.requestData(type: .DELETE, URLString: "http://127.0.0.1:8080/myapp/removeorder", parameters: ["orderId" : orderId]) { (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            let flag : Bool = (resultDict["success"] != nil)
            print("数据已成功删除")
            finishedCallback(flag)

        }
    }
}
