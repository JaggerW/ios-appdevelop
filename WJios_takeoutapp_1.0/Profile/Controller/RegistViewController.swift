//
//  RegistViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 30/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

class RegistViewController: UIViewController {

    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userTel: UITextField!
    
    private let userVM = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func Commit(_ sender: Any) {
        if userId.text != nil && userName.text != nil && userPassword.text != nil && userTel.text != nil {
            guard let id = Int(userId.text!) else {
                UIAlertController.showStatus(message: "账号输入不合法")
                return
            }
            var dict = [String : NSObject]()
            dict["userId"] = id as NSObject
            dict["userName"] = userName.text! as NSObject
            dict["userPassword"] = userPassword.text! as NSObject
            dict["userTel"] = userTel.text! as NSObject
            //添加图片信息
            //dict["userImage"] = "" as NSObject
            userVM.submitData(dict: dict, finishedCallback: { (flag) in
                if flag {
                    
                    USERID = id
                    USERNAME = dict["userName"] as! String
                    self.navigationController?.popToRootViewController(animated: true)
                    UIAlertController.showStatus(message: "注册成功！")
                }
                else{
                    UIAlertController.showStatus(message: "注册失败！")
                }
            })
        }
        else{
            UIAlertController.showStatus(message: "请完善信息！")
        }
        
    }
    

}
