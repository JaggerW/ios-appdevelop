//
//  AddressViewModel.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 27/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

class AddressViewModel: NSObject {
    
    lazy var addressList: [AddressModel] = [AddressModel]()

    
    //请求数据
    func requestData(finishedCallback: @escaping () ->()){
        print("开始请求地址信息")
        NetworkTools.requestData(type: .GET, URLString: "http://127.0.0.1:8080/myapp/listaddress", parameters: ["userId" : "\(USERID)"]) { (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let dataAarry = resultDict["data"] as? [[String : NSObject]] else {return}
            self.addressList.removeAll()
            //遍历数组，将字典转模型
            for dict in dataAarry{
                let address = AddressModel(dict: dict)
                self.addressList.append(address)
            }
            print("地址信息请求完毕")
            finishedCallback()
        }
    }
    
    //增加新地址
    func submitData(dict : [String : NSObject],finishedCallback : @escaping (_ flag : Bool) -> ()){
        NetworkTools.submitData(type: .POST, URLString: "http://127.0.0.1:8080/myapp/addaddress", parameters: dict) { (result) in
            
            guard let resultDict = result as? [String : NSObject] else {return}
            let flag : Bool = (resultDict["success"] != nil)
            print("数据提交完毕")
            finishedCallback(flag)
        }
        
    }
    
    //修改地址信息
    func updateData(dict : [String : NSObject],finishedCallback : @escaping (_ flag : Bool) -> ()){
        NetworkTools.submitData(type: .POST, URLString: "http://127.0.0.1:8080/myapp/modifyaddress", parameters: dict) { (result) in
            
            guard let resultDict = result as? [String : NSObject] else {return}
            let flag : Bool = (resultDict["success"] != nil)
            print("数据修改完毕")
            finishedCallback(flag)
        }
    }
    
    //删除
    func deleteData(addressId : Int , finishedCallback : @escaping (_ flag : Bool) -> ()){
        NetworkTools.requestData(type: .DELETE, URLString: "http://127.0.0.1:8080/myapp/removeaddress", parameters: ["addressId" : "\(addressId)"]) { (result) in
            
            guard let resultDict = result as? [String : NSObject] else {return}
            let flag : Bool = (resultDict["success"] != nil)
            print("数据已成功删除")
            finishedCallback(flag)
            
        }
    }
    
    
}
