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

}

//MARK:- 设置UI
extension DiscoverTableViewController{
    
    private func setupUI(){
        //1. 设置headerview
        setupHeaderView()
    }
    
    private func setupHeaderView(){
        let rect = CGRect(x: 0, y: 0, width: kScreenW, height: 160 + 120 + 10)
        let headerview = DiscoverHeaderView(frame: rect)
        self.tableView.tableHeaderView = headerview
    }
    
    
}












