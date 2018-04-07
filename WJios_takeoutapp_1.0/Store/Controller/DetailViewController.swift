//
//  DetailViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 08/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let detailTableViewCellID = "detailTableViewCellID"

class DetailViewController: UIViewController {
    
    var storeModel = StoreListModel()
    
    //MARK:- 懒加载
    private lazy var detailTableView: UITableView = { [weak self] in
        let rect = CGRect(x: 0, y: 0, width: (self?.view.frame.width)!, height: (self?.view.frame.height)!)
        let tableView = UITableView(frame: rect)
        
        tableView.delegate = self
        tableView.dataSource = self
        //注册cell
        let nib = UINib(nibName: "DetailTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: detailTableViewCellID)
        tableView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        tableView.backgroundColor = UIColor.white
        tableView.bounces = false
        return tableView
    }()
    

    private lazy var nameLabels: [[String]] = {
        let nameLabels = [["商家配送","配送时效","起送价格"],["限时活动","限时活动"],["简介","公告","商家电话","地址","营业时间","营业资质"]]
        return nameLabels
    }()
    
    private lazy var detailLabels: [[String]] = {
        let array_1 = ["距离\(storeModel.storeDistance)米，配送费为¥\(storeModel.deliveryCost)",
        "\(storeModel.sendStartTime)--\(storeModel.sentEndTime)","¥\(storeModel.sendingPrice)"]
        let array_2 = [storeModel.storeActivityTip1,storeModel.storeActivityTip2]
        let array_3 = [storeModel.briefIntroduction,storeModel.storeNotice,storeModel.storeTel,
                       storeModel.storeAddress,array_1[1],"许可证号:" + storeModel.storeQualification]
        var detailLabels = [[String]]()
        detailLabels.append(array_1)
        detailLabels.append(array_2)
        detailLabels.append(array_3)
        return detailLabels
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
extension DetailViewController{
    private func setupUI(){
        
        self.view.addSubview(detailTableView)
    }
}

//MARK:- 设置delegate和datasource
extension DetailViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = RightTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 20))
        let titles = ["配送信息","活动信息","商家信息"]
        headerView.nameLabel.text = titles[section]
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 3
        }
        else if section == 1{
            return 2
        }
        else {
            return 6
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailTableViewCellID, for: indexPath) as! DetailTableViewCell
        cell.nameLabel.text = nameLabels[indexPath.section][indexPath.row]
        cell.detailLabel.text = detailLabels[indexPath.section][indexPath.row]
        
        if (indexPath.section == 0) && (indexPath.row == 0){
            cell.nameLabel.backgroundColor = UIColor(r: 97, g: 166, b: 255)
            cell.nameLabel.textAlignment = .center
        }
        else if (indexPath.section == 0) && (indexPath.row == 2){
            cell.detailLabel.textColor = UIColor.red
        }
        else if (indexPath.section == 1){
            cell.nameLabel.textColor = UIColor.red
        }
        return cell
        
    }
    
    
}























