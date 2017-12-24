//
//  NotificationTableViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 20/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let NotificationTableViewCellID = "NotificationTableViewCellID"

class NotificationTableViewController: UITableViewController {
    //懒加载
    
    

    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置ui
        //注册cell
        let nib = UINib(nibName: "NotificationTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NotificationTableViewCellID)
        //设置tableview属性
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCellID, for: indexPath) as! NotificationTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetailVc = UIStoryboard(name: "OrderDetail", bundle: nil).instantiateInitialViewController() as! OrderDetailViewController
        //let storeVc = StoreViewController()
        orderDetailVc.message = indexPath.row
        self.navigationController?.pushViewController(orderDetailVc, animated: true)
    }
    
}
