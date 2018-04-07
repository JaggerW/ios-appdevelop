//
//  HomeViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 24/11/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit
import CoreLocation

private let identifier = "shoppingCell"

class HomeViewController: UIViewController{
    
//MARK:- 设置与storyboard中的连接属性
    
    @IBOutlet weak var tableView: UITableView!
    
//MARK:- 懒加载

    private lazy var headerView: HomeHeaderView = {
        let rect = CGRect(x: 0, y: 0, width: kScreenW, height: 320)
        let headerView = HomeHeaderView(frame: rect)
        return headerView
    }()
    
    private lazy var leftBtn : UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "南京", style: .plain, target: self, action: nil)
        return btn
    }()
    
    lazy var storeListVM : ListStoreViewModel = ListStoreViewModel()
    
    private lazy var storeIdArray : [Int] = []
    private lazy var storeNameArray : [String] = []
//MARK:- 系统回调函数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //注册cell
        let tableViewCellNib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(tableViewCellNib, forCellReuseIdentifier: identifier)
        

        //设置UI
        setupUI()
        //发送网络请求
        loadData()
        
    }
    
    @IBAction func searchStore(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SearchStoryBoard") as! SearchViewController
        //传值
        vc.storeName = storeNameArray
        vc.storeId = storeIdArray
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func chooseAddress(_ sender: Any) {
    }
}



//MARK:- 设置UI

extension HomeViewController{
    private func setupUI(){
        //添加headerview
        self.navigationItem.leftBarButtonItem = leftBtn
        self.tableView.tableHeaderView = headerView
    }
    
    private func loadData(){
        storeListVM.requestData {
            for store in self.storeListVM.storeList{
                self.storeNameArray.append(store.storeName)
                self.storeIdArray.append(store.storeId)
            }
            self.tableView.reloadData()
        }
    }
}


// MARK:- 设置tableviw数据源以及其代理

extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let num = storeListVM.storeList.count
        print(num)
        return storeListVM.storeList.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! TableViewCell
        let store = storeListVM.storeList[indexPath.item]
        cell.store = store
        //storeIdArray.append(store.storeId)
        //storeNameArray.append(store.storeName)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 140
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击了：\(indexPath)")
        print("点击了：\(storeIdArray[indexPath.item])")
        let storeVc = UIStoryboard(name: "Store", bundle: nil).instantiateInitialViewController() as!StoreViewController
        storeVc.store_tag = indexPath.row
        print(storeVc.store_tag)
        storeVc.store_id = storeListVM.storeList[indexPath.row].storeId
        storeVc.storeModel = storeListVM.storeList[indexPath.row]
        self.navigationController?.pushViewController(storeVc, animated: true)
    }
    
}
