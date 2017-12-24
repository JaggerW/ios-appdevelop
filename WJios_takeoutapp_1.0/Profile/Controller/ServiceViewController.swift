//
//  ServiceViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 21/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let cellID = "cellID"

class ServiceViewController: UIViewController {
    
    //MARK:- 懒加载
    private lazy var questions: [String] = {
        let string  = ["怎么催单？","我的订单超时了怎么办？","怎么退单","商家拒绝退单怎么办？","我是新用户吗？","我的红包为什么用不了？","错送漏送餐品怎么办？","怎么投诉","怎么投诉","怎么投诉","怎么投诉","怎么投诉"]
        return string
    }()

    //MARK:- 定义属性
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

//MARK:- 设置delegate 和 DataSource
extension ServiceViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellID)
            cell.textLabel?.text = questions[indexPath.row]
            cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}





