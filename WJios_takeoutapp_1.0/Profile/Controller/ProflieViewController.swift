//
//  ProflieViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 12/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let headerViewH: CGFloat = 100 + (kScreenW - 2) * 2 / 9
private let profileTableViewCellID = "profileTableViewCellID"

class ProflieViewController: UITableViewController {
    
    //MARK:- 懒加载
    private lazy var imageName: [[String]] = {
        let string = [["profile_icon_vip"],["profile_icon_address","profile_icon_like"],["profile_icon_service_center","profile_icon_business"]]
        return string
    }()

    private lazy var labelName: [[String]] = {
        let string = [["会员"],["收货地址","我的收藏"],["服务中心","推荐好友"]]
        return string
    }()
    private lazy var headerView: ProfileTableHeaderView = {
        let rect = CGRect(x: 0, y: 0, width: kScreenW, height: headerViewH)
        let headerView = ProfileTableHeaderView(frame: rect)
        //设置代理
        headerView.delegate = self
        
        return headerView
    }()
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //注册cell
        let nib = UINib(nibName: "ProfileTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: profileTableViewCellID)
        
        //添加headerview
        tableView.tableHeaderView = headerView
        //设置属性
        tableView.showsVerticalScrollIndicator = false 
        //设置ui
        setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 2
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: profileTableViewCellID, for: indexPath) as! ProfileTableViewCell
        cell.imageName.image = UIImage(named: imageName[indexPath.section][indexPath.row])
        cell.labelName.text = labelName[indexPath.section][indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 1) && (indexPath.row == 0){
            let story = UIStoryboard(name: "Address", bundle: nil)
            let vc = story.instantiateInitialViewController() as! AddressViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}


//MARK:- 设置UI
extension ProflieViewController{
    private func setupUI(){
        //设置uibutton
        
    }
}

//MARK:- 遵守headerview的delegate
extension ProflieViewController: ProfileTableHeaderDelegate{
    
    func ClickHeader(headerView: ProfileTableHeaderView) {
        let story = UIStoryboard(name: "User", bundle: nil)
        let vc = story.instantiateInitialViewController() as! UserTableViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func SelectItem(headerView: ProfileTableHeaderView, Index: Int, Num: String) {
        switch Index {
        case 0:
            print(Num)
            let story = UIStoryboard(name: "Wallet", bundle: nil)
            let vc = story.instantiateInitialViewController() as! WalletViewController
            vc.num = Num
            
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            print(Num)
            let vc = DiscountViewController()
            let num = Int(Num)
            vc.count = num!
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            print(Num)
            let vc = CreditsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("还没完成")
        }
    }
    
    
}

































