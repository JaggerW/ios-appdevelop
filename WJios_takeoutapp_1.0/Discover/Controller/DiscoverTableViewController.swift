//
//  DiscoverTableViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 30/11/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let identifier = "tableviewCell"

class DiscoverTableViewController: UITableViewController {
    
    //MARK:- 懒加载
    private lazy var headerView: DiscoverHeaderView = {
        let rect = CGRect(x: 0, y: 0, width: kScreenW, height: 160 + 120 + 10)
        let headerView = DiscoverHeaderView(frame: rect)
        headerView.delegate = self
        return headerView
    }()
    
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI
        setupUI()
        
        //注册tableviewcell
        let nib = UINib(nibName: "DiscoverTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
//        tableView.register(DiscoverTableViewCell.self, forCellReuseIdentifier: identifier)
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        return cell!
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 188
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击了：\(indexPath)")
        let storeVc = UIStoryboard(name: "Store", bundle: nil).instantiateInitialViewController()!
        //let storeVc = StoreViewController()
        self.navigationController?.pushViewController(storeVc, animated: true)
    }

}

//MARK:- 设置UI
extension DiscoverTableViewController{
    
    private func setupUI(){
        //1. 添加headerview
        self.tableView.tableHeaderView = headerView
    }
    
}

//MARK:- 遵守headview的delegate
extension DiscoverTableViewController: DiscoverCollectionViewDelegate{
    func ClickItem(DiscoverView: DiscoverHeaderView, Index: Int) {
        print(Index)
        //弹出控制器
        switch Index {
        case 0:
            let vc = CreditsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("还没完成")
        }
    }
    
    
}












