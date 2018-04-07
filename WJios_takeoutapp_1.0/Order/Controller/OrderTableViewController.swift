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
    
    
    //请求数据提交数据
    lazy var orderVM = OrderViewModel()
    //存储orderID
    private lazy var orderIdArray : [String] = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "OrderTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: identifier)
        
    }
    //请求数据
    private func loadData(){
        orderVM.requestData(userId: USERID) {
            self.tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if USERID == 0{
            UIAlertController.showConfirm(message: "请先登录！", confirm: { (_) in
                let vc = UIStoryboard(name: "Logon", bundle: nil).instantiateInitialViewController() as! LogonViewController
                self.navigationItem.backBarButtonItem?.title = "订单"
                self.navigationController?.pushViewController(vc, animated: true)
            })
        }
        else{
            //请求数据
            loadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orderVM.orderList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //获取cell
        let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier) as! OrderTableViewCell
        //获取模型
        let count = orderVM.orderList.count - 1
        let order = orderVM.orderList[count - indexPath.row]
        //赋值
        cell.order = order
        cell.againButton.tag = count - indexPath.row
        cell.indexPath = indexPath
        cell.delegate = self
        orderIdArray.append(order.orderId)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let count = orderVM.orderList.count - 1
        let orderDetailVc = UIStoryboard(name: "OrderDetail", bundle: nil).instantiateInitialViewController() as! OrderDetailViewController
        //将当前该cell的数据模型传递到订单详情页面
        orderDetailVc.orderModel = orderVM.orderList[count - indexPath.row]
        self.navigationController?.pushViewController(orderDetailVc, animated: true)
    }

}


//MARK:- 实现cell的delegate
extension OrderTableViewController: OrderTableViewCellDelegate{
    //长按删除cell
    func LongPress(cellView: OrderTableViewCell, indexPath: IndexPath) {
        UIAlertController.showConfirm(message: "确定要删除此订单信息？", confirm: { (_) in
            let count = self.orderVM.orderList.count - 1 - indexPath.row
            let id = self.orderIdArray[indexPath.row]
            //删除服务端数据
            self.orderVM.deleteData(orderId: id, finishedCallback: { (_) in
                print("已成功删除")
                //删除数组中的数据
                self.orderVM.orderList.remove(at: count)
                self.tableView.deleteRows(at: [indexPath], with: .right)
                self.tableView.reloadData()
                return
            })
        })
    }
    //取消订单
    func CancelTheOrder(cellView: OrderTableViewCell, IndexRow: Int){
            var dict = self.toDict(index: IndexRow)
            dict["orderStatus"] = 2 as NSObject
            dict["arriveTime"] = "订单已被取消" as NSObject
            //modify
            self.orderVM.orderList[IndexRow].orderStatus = 2
            self.orderVM.orderList[IndexRow].arriveTime = "订单已被取消"
            self.orderVM.updateData(dict: dict, finishedCallback: { (flag) in
                if flag{
                    
                    UIAlertController.showStatus(message: "订单已取消")
                }
                else{
                    UIAlertController.showStatus(message: "订单取消失败")
                }
            
        })
    }
    //确认收货
    func ClickTheButton(cellView: OrderTableViewCell, IndexRow: Int) -> Int{
        //确认收货
        let status = orderVM.orderList[IndexRow].orderStatus
        if status == 0{
            //1. 将model转成字典
                var dict = toDict(index: IndexRow)
                dict["orderStatus"] = 1 as NSObject
                let currentDate = NSDate.getCurrentTime()
                let arriveTime = String(describing: NSDate(timeIntervalSince1970: Double(currentDate)))
                dict["arriveTime"] = arriveTime as NSObject
                self.orderVM.orderList[IndexRow].orderStatus = 1
                self.orderVM.orderList[IndexRow].arriveTime = arriveTime
                //modify
                self.orderVM.updateData(dict: dict, finishedCallback: { (flag) in
                    if flag{
                        UIAlertController.showStatus(message: "订单已完成")
                    }
                    else{
                        UIAlertController.showStatus(message: "确认收货失败")
                    }
                })
               return 1
        }
        else{
            let storeId = orderVM.orderList[IndexRow].storeId
            let storeVc = UIStoryboard(name: "Store", bundle: nil).instantiateInitialViewController() as! StoreViewController
            storeVc.store_id = storeId
            self.navigationController?.pushViewController(storeVc, animated: true)
            return 0
        }
    }
}

extension OrderTableViewController{
    //模型转字典
    private func toDict(index : Int) -> [String : NSObject]{
        var dict = [String : NSObject]()
        let orderModel = orderVM.orderList[index]
        dict["orderId"] = orderModel.orderId as NSObject
        dict["orderStatus"] = orderModel.orderStatus as NSObject
        dict["commentFlag"] = orderModel.commentFlag as NSObject
        dict["storeId"] = orderModel.storeId as NSObject
        dict["storeName"] = orderModel.storeName as NSObject
        dict["orderTime"] = orderModel.orderTime as NSObject
        let arriveTime = orderModel.arriveTime ?? "正在配送中"
        dict["arriveTime"] = arriveTime as NSObject
        dict["address"] = orderModel.address as NSObject
        dict["deliverySide"] = orderModel.deliverySide as NSObject
        dict["payWay"] = orderModel.payWay as NSObject
        dict["deliveryCost"] = orderModel.deliveryCost as NSObject
        dict["preferentialPrice"] = orderModel.preferentialPrice as NSObject
        dict["payCost"] = orderModel.payCost as NSObject
        dict["userId"] = orderModel.userId as NSObject
        var goodsArray = [[String : NSObject]]()
        for goods in orderModel.goodsList{
            var dict = [String : NSObject]()
            dict["goodsName"] = goods.goodsName as NSObject
            dict["goodsCount"] = goods.orderCount as NSObject
            dict["goodsPrice"] = goods.goodsPrice as NSObject
            dict["goodsImage"] = goods.goodsImage as NSObject
            dict["orderId"] = orderModel.orderId as NSObject
            goodsArray.append(dict)
        }
        dict["goods"] = goodsArray as NSObject
        return dict
    }
}


