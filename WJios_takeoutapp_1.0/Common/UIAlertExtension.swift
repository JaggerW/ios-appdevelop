//
//  UIAlertExtension.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 21/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

extension UIAlertController {
    //在指定视图控制器上弹出普通消息提示框
    static func showAlert(message: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel))
        viewController.present(alert, animated: true)
    }
    
    //在根视图控制器上弹出普通消息提示框
    static func showAlert(message: String) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showAlert(message: message, in: vc)
        }
    }
    
    //在指定视图控制器上弹出确认框
    static func showConfirm(message: String, in viewController: UIViewController,
                            confirm: ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: "系统提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: confirm))
        viewController.present(alert, animated: true)
    }
    
    //在根视图控制器上弹出确认框
    static func showConfirm(message: String, confirm: ((UIAlertAction) -> Void)?){
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showConfirm(message: message, in: vc, confirm: confirm)
        }
    }
    
    //在根视图控制器上弹出不带按钮的消息提示框
    static func showStatus(message: String){
        let alert = UIAlertController(title: "系统提示", message: message, preferredStyle: .alert)
        if let vc = UIApplication.shared.keyWindow?.rootViewController{
            vc.present(alert, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
                vc.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            
        }
        
    }
}
