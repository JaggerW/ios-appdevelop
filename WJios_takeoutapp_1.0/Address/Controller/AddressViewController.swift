//
//  AddressViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 14/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let buttonH: CGFloat = 48
private let tableViewH: CGFloat = kScreenH - buttonH
private let addressTableViewCellID = "addressTableViewCellID"
private let AddAddressStoryBoardID = "AddAddressStoryBoardID"

class AddressViewController: UIViewController {
    
    //MARK:- 懒加载
    private lazy var tableView: UITableView = {
        //设置tableview
        let rect = CGRect(x: 0, y: 0, width: kScreenW, height: tableViewH)
        let tableView = UITableView(frame: rect)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.backgroundColor = UIColor.groupTableViewBackground
        //设置代理
        tableView.delegate = self
        tableView.dataSource = self
        //注册cell
        let nib = UINib(nibName: "AddressTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: addressTableViewCellID)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置ui
        self.view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func addAddress(_ sender: Any) {
        let vc = UIStoryboard(name: "Address", bundle: nil).instantiateViewController(withIdentifier: AddAddressStoryBoardID)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK:- 设置代理与数据源
extension AddressViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: addressTableViewCellID, for: indexPath) as! AddressTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}
