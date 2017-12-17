//
//  OrderTableViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 29/11/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let identifier = "orderCell"

class OrderTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "OrderTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: identifier)
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier) as! OrderTableViewCell
        cell.againButton.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击了：\(indexPath)")
        let orderDetailVc = UIStoryboard(name: "OrderDetail", bundle: nil).instantiateInitialViewController() as! OrderDetailViewController
        //let storeVc = StoreViewController()
        orderDetailVc.message = indexPath.row
        self.navigationController?.pushViewController(orderDetailVc, animated: true)
    }


}

//MARK:- 实现cell的delegate
extension OrderTableViewController: OrderTableViewCellDelegate{
    func ClickTheButton(cellView: OrderTableViewCell, IndexRow: Int) {
        print(IndexRow)
        let storeVc = UIStoryboard(name: "Store", bundle: nil).instantiateInitialViewController()!
                //let storeVc = StoreViewController()
                self.navigationController?.pushViewController(storeVc, animated: true)
    }
}


