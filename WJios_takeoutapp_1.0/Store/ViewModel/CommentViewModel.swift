//
//  CommentViewModel.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 03/04/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

class CommentViewModel: NSObject {

    lazy var commentList : [CommentModel] = [CommentModel]()
    
    //var store_id : Int = 0
    
    //请求数据
    func requestData(storeId : Int , finishedCallback: @escaping () ->()){
        print("开始请求评价数据")
        NetworkTools.requestData(type: .GET, URLString: "http://127.0.0.1:8080/myapp/listcomment", parameters: ["storeId" : "\(storeId)"]) { (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let dataAarry = resultDict["data"] as? [[String : NSObject]] else {return}
            self.commentList.removeAll()
            //遍历数组，将字典转模型
            for dict in dataAarry{
                let model = CommentModel(dict: dict)
                self.commentList.append(model)
            }
            print("评价数据请求完毕")
            finishedCallback()
        }
    }
    
    //提交数据
    func submitData(dict : [String : NSObject],finishedCallback : @escaping (_ flag : Bool) -> ()){
        NetworkTools.submitData(type: .POST, URLString: "http://127.0.0.1:8080/myapp/addcomment", parameters: dict) { (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            let flag : Bool = (resultDict["success"] != nil)
            print("数据提交完毕")
            finishedCallback(flag)
        }
        
    }
    
    
}














