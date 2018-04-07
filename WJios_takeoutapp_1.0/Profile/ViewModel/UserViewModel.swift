//
//  UserViewModel.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 30/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

class UserViewModel: NSObject {

    var userModel = UserModel()
    
    override init() {
        
    }
    
    //提交数据
    func submitData(dict : [String : NSObject],finishedCallback : @escaping (_ flag : Bool) -> ()){
        NetworkTools.submitData(type: .POST, URLString: "http://127.0.0.1:8080/myapp/adduser", parameters: dict) { (result) in
            
            guard let resultDict = result as? [String : NSObject] else {return}
            let flag : Bool = (resultDict["success"] != nil)
            print("数据提交完毕")
            finishedCallback(flag)
        }
        
    }
    
    //请求数据
    func requestData(userId : Int, finishedCallback : @escaping () ->()){
        print("开始请求数据")
        NetworkTools.requestData(type: .GET, URLString: "http://127.0.0.1:8080/myapp/getuser", parameters: ["userId" : "\(userId)"]) { (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let data = resultDict["user"] as? [String : NSObject] else {return}
            self.userModel = UserModel(dict: data)
            print("用户数据请求完毕")
            finishedCallback()
        }
        
    }
}
