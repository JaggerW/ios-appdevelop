//
//  ListGoodsViewModel.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 17/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

class ListGoodsViewModel {

    //懒加载
    lazy var goodsGroups : [GoodsGroup] = [GoodsGroup]()
    
    var store_id : Int = 0
    
    //MARK:- 请求数据
    
    func requestData(storeId : Int , finishedCallback: @escaping () ->()){
        print("开始请求商品数据")
        NetworkTools.requestData(type: .GET, URLString: "http://127.0.0.1:8080/myapp/getgoods", parameters: ["storeId" : "\(storeId)"]) { (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let dataAarry = resultDict["data"] as? [[String : NSObject]] else {return}
            self.goodsGroups.removeAll()
            //遍历数组，将字典转模型
            for dict in dataAarry{
                let group = GoodsGroup(dict: dict)
                self.goodsGroups.append(group)
            }
            for group in self.goodsGroups{
                print(group.categoryName)
            }
            print("商品数据请求完毕")
            finishedCallback()
        }
    }
}
