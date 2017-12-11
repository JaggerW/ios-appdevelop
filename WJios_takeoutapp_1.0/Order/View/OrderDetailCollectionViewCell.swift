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
    
    private lazy var detailTableView:UITableView = { [weak self] in
        let rect = (self?.contentView.bounds)!
        let tableView = UITableView(frame: rect)
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var headerView: UIView = {
        let rect = CGRect(x: 0, y: 0, width: detailTableView.frame.width, height: 45)
        let header = UIView(frame: rect)
        let labelrect = CGRect(x: 10, y: 5, width: detailTableView.frame.width - 80, height: 21)
        let label = UILabel(frame: labelrect)
        label.text = "商家名称"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        header.addSubview(label)
        return header
    }()
    private lazy var footerView: OrderDetailTableFooterView = { [weak self] in
        let rect = CGRect(x: 0, y: detailTableView.bounds.size.height - kFooterH, width: detailTableView.bounds.width, height: kFooterH)
        let footer = OrderDetailTableFooterView(frame: rect)
        return footer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
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
        detailTableView.tableHeaderView = headerView
        detailTableView.tableFooterView = footerView
        self.contentView.addSubview(detailTableView)
        
    }
}

extension OrderDetailCollectionViewCell: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "reusedCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = "烤鸭+锁骨+时蔬+开胃小菜+米饭"
        cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        cell?.detailTextLabel?.text = "¥20"
        cell?.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        return cell!
        
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: <#T##String#>)
//        tableView.regi
//    }
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        <#code#>
//    }
    
}

