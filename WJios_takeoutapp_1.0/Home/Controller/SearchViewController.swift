//
//  SearchViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 04/04/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var storeId : [Int] = []
    var storeName : [String] = []
    var result : [String] = []
    var dict : [String : Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 起始加载全部内容
        self.result = self.storeName
        for count in 0..<storeId.count{
            dict[storeName[count]] = storeId[count]
        }
        //设置代理
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // 注册TableViewCell
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func GoBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.result.count
    }
    // 创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            // 为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "cell"
            // 同一形式的单元格重复使用，在声明时已注册
            let cell = tableView.dequeueReusableCell(withIdentifier: identify,
                                                     for: indexPath)
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = self.result[indexPath.row]
            
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storename = self.result[indexPath.row]
        let storeid : Int = self.dict[storename]!
        print(storeid)
        let storeVc = UIStoryboard(name: "Store", bundle: nil).instantiateInitialViewController() as!StoreViewController
        //storeVc.store_tag = indexPath.row
        //print(storeVc.store_tag)
        storeVc.store_id = storeid
        //storeVc.storeModel = storeListVM.storeList[indexPath.row]
        self.navigationController?.pushViewController(storeVc, animated: true)
    }
    
    // 搜索代理UISearchBarDelegate方法，每次改变搜索内容时都会调用
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print(searchText)
        // 没有搜索内容时显示全部组件
        if searchText == "" {
            self.result = self.storeName
        }
        else { // 匹配用户输入内容的前缀(不区分大小写)
            self.result = []
            for ctrl in self.storeName {
                if ctrl.lowercased().hasPrefix(searchText.lowercased()) {
                    self.result.append(ctrl)
                }
            }
        }
        // 刷新Table View显示
        self.tableView.reloadData()
    }
    
    // 搜索代理UISearchBarDelegate方法，点击虚拟键盘上的Search按钮时触发
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}

