//
//  UIBarButtonItem.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 06/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit
extension UIBarButtonItem{
    //便利构造函数
    //1. convenience开头
    //2. 在构造函数中必须明确调用一个设计的构造函数（self）
    convenience init(imageName: String,highImageName: String = "",size: CGSize = CGSize.zero){
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        if highImageName != ""{
            btn.setImage(UIImage(named:highImageName), for: .highlighted)
        }
        if size == CGSize.zero{
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin:CGPoint.zero, size: size)
        }
        self.init(customView :btn)
    }
}
