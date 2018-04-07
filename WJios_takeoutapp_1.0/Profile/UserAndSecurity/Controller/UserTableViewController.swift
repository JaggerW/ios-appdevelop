//
//  UserTableViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 14/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userTel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBAction func checkOut(_ sender: Any) {
        UIAlertController.showConfirm(message: "确定退出吗？") { (_) in
            USERID = 0
            //重新刷新界面
            self.navigationController?.popViewController(animated: true)
        }
    }
    private let userVM = UserViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置ui
        self.tableView.bounces = false
        self.tableView.showsVerticalScrollIndicator = false
        //
        userVM.requestData(userId: USERID) {
            let model = self.userVM.userModel
            self.userName.text = model.userName
            self.userTel.text = model.userTel
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2{
            return 0.01
        }
        else {
            return 0.01
        }
    }
    
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return nil
//    }

    
}
