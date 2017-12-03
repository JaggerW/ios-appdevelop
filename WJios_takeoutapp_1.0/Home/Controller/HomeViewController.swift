//
//  HomeViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 24/11/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

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
    
//MARK:- 系统回调函数
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //tableView.register(TableViewCell.self, forCellReuseIdentifier: identifier)
        let tableViewCellNib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(tableViewCellNib, forCellReuseIdentifier: identifier)
        

        
        setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



//MARK:- 设置UI

extension HomeViewController{
    private func setupUI(){
        //添加headerview
        self.tableView.tableHeaderView = headerView
    }
}




// MARK:- 设置tableviw数据源以及其代理

extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 140
    }

    
}
