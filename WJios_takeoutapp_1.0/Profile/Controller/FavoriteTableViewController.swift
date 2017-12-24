//
//  FavoriteTableViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 20/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let identifier = "shoppingCell"

class FavoriteTableViewController: UITableViewController {

    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:- 设置UI
        //注册cell
        let tableViewCellNib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(tableViewCellNib, forCellReuseIdentifier: identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! TableViewCell
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击了：\(indexPath)")
        let storeVc = UIStoryboard(name: "Store", bundle: nil).instantiateInitialViewController() as! StoreViewController
        //let storeVc = StoreViewController()
        self.navigationController?.pushViewController(storeVc, animated: true)
    }
    

}
