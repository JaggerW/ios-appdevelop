//
//  CommentViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 08/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let headerViewH:CGFloat = 96
private let commenTableViewCellID = "commentTableViewCellID"

class CommentViewController: UIViewController {
    
    //MARK:- 懒加载
    //懒加载header
    private lazy var commenTableHeaderView:CommentHeaderView = { [weak self] in
        let rect = CGRect(x: 0, y: 0, width: (self?.view.frame.width)!, height: headerViewH)
        let headerview = CommentHeaderView(frame: rect)
        return headerview
    }()
    
    //懒加载tableview
    private lazy var commentTableView: UITableView = {
        //1. 创建tableview
        let tableView = UITableView(frame: self.view.bounds)
        
        //1.1 设置tableview的属性
        tableView.bounces = true
        tableView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        tableView.backgroundColor = UIColor.white
        
        //2. 设置tableview的header
        //tableView.tableHeaderView = commenTableHeaderView
        
        //3. 设置tableview的delegate和DataSource
        tableView.delegate = self
        tableView.dataSource = self
        
        //4. 注册cell
        let nib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: commenTableViewCellID)
        return tableView
    }()

    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置ui
        setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

//MARK:- 设置UI
extension CommentViewController{
    private func setupUI(){
        //1. 添加tableview
        self.view.addSubview(commentTableView)
        commentTableView.tableHeaderView = commenTableHeaderView
        
    }
}

//MARK:- 设置tableview的delegate和DataSource
extension CommentViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: commenTableViewCellID, for: indexPath)
        cell.bounds.size.height = 200
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}















