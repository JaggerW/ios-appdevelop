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
        if USERID != 0{
            userVM.requestData(userId: USERID, finishedCallback: {
                let model = self.userVM.userModel
                headerView.model = model
            })
        }
        else{
            headerView.userTel.text = ""
            headerView.userName.text = "请登录"
        }
        //设置代理
        headerView.delegate = self
        
        return headerView
    }()
    private let userVM : UserViewModel = UserViewModel()
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if USERID != 0{
            userVM.requestData(userId: USERID, finishedCallback: {
                let model = self.userVM.userModel
                self.headerView.model = model
            })
        }
        else{
            headerView.userTel.text = ""
            headerView.userName.text = "请登录"
        }
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
        
        if (indexPath.section == 1) && (indexPath.row == 0) {
            let story = UIStoryboard(name: "Address", bundle: nil)
            let vc = story.instantiateInitialViewController() as! AddressViewController
            self.navigationItem.backBarButtonItem?.title = "收货地址"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if (indexPath.section == 2) && (indexPath.row == 1) {
            let vc = UIStoryboard(name: "Invitation", bundle: nil).instantiateInitialViewController() as! InvitationViewController
            self.navigationItem.backBarButtonItem?.title = "推荐有奖"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if (indexPath.section == 1) && (indexPath.row == 1) {
            let vc = FavoriteTableViewController()
            self.navigationItem.backBarButtonItem?.title = "我的收藏"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if (indexPath.section == 2) && (indexPath.row == 0) {
            let vc = UIStoryboard(name: "Service", bundle: nil).instantiateViewController(withIdentifier: "ServiceStoryBoardID") as! ServiceViewController
            self.navigationItem.backBarButtonItem?.title = "我的客服"
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
        if USERID != 0{
            let story = UIStoryboard(name: "User", bundle: nil)
            let vc = story.instantiateInitialViewController() as! UserTableViewController
            self.navigationItem.backBarButtonItem?.title = "账户与安全"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = UIStoryboard(name: "Logon", bundle: nil).instantiateInitialViewController() as! LogonViewController
            self.navigationItem.backBarButtonItem?.title = "账户与安全"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func SelectItem(headerView: ProfileTableHeaderView, Index: Int, Num: String) {
        switch Index {
        case 0:
            print(Num)
            let story = UIStoryboard(name: "Wallet", bundle: nil)
            let vc = story.instantiateInitialViewController() as! WalletViewController
            vc.num = Num
            self.navigationItem.backBarButtonItem?.title = "钱包"
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            print(Num)
            let vc = DiscountViewController()
            let num = Int(Num)
            vc.count = num!
            self.navigationItem.backBarButtonItem?.title = "红包"
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            print(Num)
            let vc = CreditsViewController()
            self.navigationItem.backBarButtonItem?.title = "积分"
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("还没完成")
        }
    }
    
    
}

































