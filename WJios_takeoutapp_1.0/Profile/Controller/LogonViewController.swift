//
//  LogonViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 30/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

class LogonViewController: UIViewController {

    @IBOutlet weak var userId: UITextField!
    
    @IBOutlet weak var passWord: UITextField!
    
    private var userVM = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func Logon(_ sender: Any) {
        if userId.text == nil{
            UIAlertController.showStatus(message: "请输入账号")
            return
        }
        else if passWord.text == nil {
            UIAlertController.showStatus(message: "请输入密码")
            return
        }
        else{
            guard let id = Int(userId.text!) else {
                UIAlertController.showStatus(message: "账号不合法")
                return
            }
            userVM.requestData(userId: id, finishedCallback: {
                if self.userVM.userModel.userPassword == self.passWord.text{
                    USERID = self.userVM.userModel.userId
                    USERNAME = self.userVM.userModel.userName
                    //传递信息至前页
                    self.navigationController?.popViewController(animated: true)
                    UIAlertController.showStatus(message: "登录成功")
                }
                else{
                    UIAlertController.showStatus(message: "账号或密码错误!")
                    return
                }
            })
        }
    }
    

}
