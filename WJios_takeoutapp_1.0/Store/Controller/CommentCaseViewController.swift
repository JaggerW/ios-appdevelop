//
//  CommentCaseViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 22/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let cellID = "CommentCaseTableViewCellID"

class CommentCaseViewController: UIViewController {
    
    //MARK:- 定义属性
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.groupTableViewBackground
        
        let nib = UINib(nibName: "CommentCaseTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

extension CommentCaseViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CommentCaseTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "您的评价将匿名发送给商家"
    }
}
