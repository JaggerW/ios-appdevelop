//
//  NetworkTools.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 14/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType{
    case GET
    case POST
    case PUT
    case DELETE
}

class NetworkTools{
    //请求数据，发起网络请求函数
    class func requestData(type : MethodType, URLString:String, parameters:[String : String]? = nil,finishedCallback: @escaping (_ result : AnyObject) -> ()) {
        var method = HTTPMethod.get
        switch type {
        case .GET:
            method = HTTPMethod.get
        case .POST:
            method = HTTPMethod.post
        case .PUT:
            method = HTTPMethod.put
        default:
            method = HTTPMethod.delete
        }
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                print (response.result.error as Any)
                return
            }
            
            finishedCallback(result as AnyObject)
        }
    }
    
    //提交数据
    class func submitData(type : MethodType, URLString : String, parameters : [String : NSObject], finishedCallback: @escaping (_ result : AnyObject) -> ()){
        let method = type == .POST ? HTTPMethod.post : HTTPMethod.put
        Alamofire.request(URLString, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            guard let result = response.result.value else{
                print (response.result.error as Any)
                return
            }
            
            finishedCallback(result as AnyObject)
        }
    }
    

}
