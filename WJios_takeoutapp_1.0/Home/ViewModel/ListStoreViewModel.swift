//
//  ListStoreViewModel.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 15/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

class ListStoreViewModel{

    //MARK:- 懒加载
    lazy var storeList : [StoreListModel] = [StoreListModel]()
    lazy var store : StoreListModel = StoreListModel()
}

//MARK:- 发送网络请求
extension ListStoreViewModel{
    func requestData(parameters: Int? = nil,finishedCallback : @escaping () -> ()){
        print("开始请求数据")
        if parameters == nil {
            NetworkTools.requestData(type: .GET, URLString: "http://127.0.0.1:8080/myapp/liststore") { (result) in
                guard let resultDict = result as? [String : NSObject] else {return}
                //获取数组
                guard let dataArray = resultDict["storeList"] as? [[String : NSObject]] else {return}
                //遍历数组，获取字典并转成数组
                for dict in dataArray{
                    let store = StoreListModel(dict: dict)
                    self.storeList.append(store)
                }
                for store in self.storeList{
                    print(store.storeName)
                }
                print("数据请求完毕")
                finishedCallback()
            }
        }
        else{
            NetworkTools.requestData(type: .GET, URLString: "http://127.0.0.1:8080/myapp/getstorebyid", parameters: ["storeId" : "\(parameters ?? 101)"], finishedCallback: { (result) in
                guard let resultDict = result as? [String : NSObject] else {return}
                //获取数组
                guard let datadict = resultDict["store"] as? [String : NSObject] else {return}
                //遍历数组，获取字典并转成数组
                self.store = StoreListModel(dict: datadict)
                print("数据请求完毕")
                finishedCallback()
            })
        }
        
//        NetworkTools.requestData(type: .GET, URLString: "http://127.0.0.1:8080/myapp/liststore") { (result) in
//            guard let resultDict = result as? [String : NSObject] else {return}
//            //获取数组
//            guard let dataArray = resultDict["storeList"] as? [[String : NSObject]] else {return}
//            //遍历数组，获取字典并转成数组
//            for dict in dataArray{
//                let store = StoreListModel(dict: dict)
//                self.storeList.append(store)
//            }
//            for store in self.storeList{
//                print(store.storeName)
//            }
//            print("数据请求完毕")
//            finishedCallback()
//        }
    
    }
}














