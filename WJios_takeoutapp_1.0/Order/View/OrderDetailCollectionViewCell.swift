//
//  OrderDetailCollectionViewCell.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 10/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let kFooterH: CGFloat = 30

class OrderDetailCollectionViewCell: UICollectionViewCell {
    
    var sectionNum: Int = 10{
        didSet{
            if sectionNum == 1{
                footerView.removeFromSuperview()
            }
        }
    }
    var orderModel = OrderModel(){
        didSet{
            ValueArray.append(orderModel.orderId)
            ValueArray.append(orderModel.arriveTime ?? "正在配送中")
            ValueArray.append(orderModel.address)
            ValueArray.append(orderModel.deliverySide)
            ValueArray.append(orderModel.payWay)
            ValueArray.append(orderModel.orderTime)
            footerView.totalCost.text = "¥\(orderModel.payCost)"
            if sectionNum == 0{
                label.text = orderModel.storeName
            }
            else{
                label.text = "订单信息"
            }
            self.detailTableView.reloadData()
        }
    }
    
    private var KeyArray = ["订单号","送达时间","收货地址","配送方式","支付方式","下单时间"]
    private var ValueArray = [String]()
    private lazy var detailTableView:UITableView = { [weak self] in
        let rect = (self?.contentView.bounds)!
        let tableView = UITableView(frame: rect)
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false 
        return tableView
    }()
    
    private lazy var headerView: UIView = {
        let rect = CGRect(x: 0, y: 0, width: detailTableView.frame.width, height: 35)
        let header = UIView(frame: rect)
        return header
    }()
    private lazy var label: UILabel = {
        let labelrect = CGRect(x: 10, y: 7, width: detailTableView.frame.width - 80, height: 21)
        let label = UILabel(frame: labelrect)
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    private lazy var footerView: OrderDetailTableFooterView = { [weak self] in
        let rect = CGRect(x: 0, y: detailTableView.bounds.size.height - kFooterH, width: detailTableView.bounds.width, height: kFooterH)
        let footer = OrderDetailTableFooterView(frame: rect)
        return footer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        print(sectionNum)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension OrderDetailCollectionViewCell{
    private func setupUI(){
        headerView.addSubview(label)
        detailTableView.tableHeaderView = headerView
        detailTableView.tableFooterView = footerView
        self.contentView.addSubview(detailTableView)
        
    }
}

extension OrderDetailCollectionViewCell: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionNum == 0 {
            return orderModel.goodsList.count + 2
        }
        else{
            return 6
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "reusedCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier)
        }
        cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        cell?.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        if sectionNum == 0{
            if indexPath.row == orderModel.goodsList.count{
                cell?.textLabel?.text = "配送费"
                cell?.textLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: 13, weight: .light)
                cell?.detailTextLabel?.text = "¥\(orderModel.deliveryCost)"
            }
            else if indexPath.row == orderModel.goodsList.count + 1{
                cell?.textLabel?.text = "优惠减免"
                cell?.textLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: 13, weight: .light)
                cell?.textLabel?.textColor = UIColor.red
                cell?.detailTextLabel?.textColor = UIColor.red
                cell?.detailTextLabel?.text = "-¥\(orderModel.preferentialPrice)"
            }
            else{
                cell?.textLabel?.text = orderModel.goodsList[indexPath.row].goodsName + "  ×\(orderModel.goodsList[indexPath.row].orderCount)"
                cell?.detailTextLabel?.text = "¥\(orderModel.goodsList[indexPath.row].goodsPrice * Float(orderModel.goodsList[indexPath.row].orderCount))"
            }
        }
        else{
            cell?.textLabel?.text = KeyArray[indexPath.row]
            cell?.detailTextLabel?.text = ValueArray[indexPath.row]
        }
        return cell!
        
    }
    
}

