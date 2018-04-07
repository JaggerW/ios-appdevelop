//
//  SearchGoodsViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 04/04/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

protocol SearchGoodsDelegate : class {
    func findGoods(viewController : SearchGoodsViewController, indexpath : IndexPath)
}

class SearchGoodsViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    //存放总数据
    var goods : [String] = []
    //存放商品cell的indexpath
    var goodsIndexPath : [IndexPath] = []
    //存放查询结果
    var result : [String] = []
    //存放商品名称和对应cell的indexpath
    var dict : [String : IndexPath] = [:]
    
    weak var delegate : SearchGoodsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.result = self.goods
        for index in 0..<goods.count{
            dict[goods[index]] = goodsIndexPath[index]
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
    
}

extension SearchGoodsViewController : UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    
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
        let goodsName = self.result[indexPath.row]
        let goodsIndexPath : IndexPath = self.dict[goodsName]!
        //通知代理
        self.delegate?.findGoods(viewController: self, indexpath: goodsIndexPath)
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    // 搜索代理UISearchBarDelegate方法，每次改变搜索内容时都会调用
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print(searchText)
        // 没有搜索内容时显示全部组件
        if searchText == "" {
            self.result = self.goods
        }
        else { // 匹配用户输入内容的前缀(不区分大小写)
            self.result = []
            for ctrl in self.goods {
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
    

