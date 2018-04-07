//
//  AddressViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 14/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

protocol AddressViewControllerDelegate : class {
    func putAddress(viewController: AddressViewController,address: String)
}

private let buttonH: CGFloat = 48
private let tableViewH: CGFloat = kScreenH - buttonH
private let addressTableViewCellID = "addressTableViewCellID"
private let AddAddressStoryBoardID = "AddAddressStoryBoardID"



class AddressViewController: UIViewController {
    
    private lazy var addressVM = AddressViewModel()
    
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

    var delegate : AddressViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //设置ui
        self.view.addSubview(tableView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if USERID == 0{
            UIAlertController.showConfirm(message: "请先登录！", confirm: { (_) in
                let vc = UIStoryboard(name: "Logon", bundle: nil).instantiateInitialViewController() as! LogonViewController
                self.navigationItem.backBarButtonItem?.title = "地址管理"
                self.navigationController?.pushViewController(vc, animated: true)
            })
        }
        else{
            //请求数据
            addressVM.requestData {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func addAddress(_ sender: Any) {
        let vc = UIStoryboard(name: "Address", bundle: nil).instantiateViewController(withIdentifier: AddAddressStoryBoardID) as! AddAddressTableViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK:- 设置代理与数据源
extension AddressViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressVM.addressList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //获取数据模型
        let model = addressVM.addressList[indexPath.row]
        //获取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: addressTableViewCellID, for: indexPath) as! AddressTableViewCell
        cell.model = model
        cell.modify.tag = indexPath.row
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PayFoodsViewController()
        //将数据传回
        vc.addressModel = addressVM.addressList[indexPath.row]
        let address = addressVM.addressList[indexPath.row].toString()
        //通知代理
        delegate?.putAddress(viewController: self, address: address)
        self.navigationController?.popViewController(animated: true)
    }
}
//MARK:- 设置celldelegate
extension AddressViewController:AddressTableViewCellDelegate{
    
    func LongPress(cellView: AddressTableViewCell, indexPath: IndexPath) {
        UIAlertController.showConfirm(message: "确定要删除此地址信息？", confirm: { (_) in
            let id = self.addressVM.addressList[indexPath.row].addressId
            //删除服务端数据
            self.addressVM.deleteData(addressId: id, finishedCallback: { (_) in
                print("已成功删除")
                //删除数组中的数据
                self.addressVM.addressList.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .right)
                self.tableView.reloadData()
                return
            })
        })
    }
    
    func ModifyAddress(viewCell: AddressTableViewCell, index: Int) {
        let model = addressVM.addressList[index]
        print(model.userName)
        let vc = UIStoryboard(name: "Address", bundle: nil).instantiateViewController(withIdentifier: AddAddressStoryBoardID) as! AddAddressTableViewController
        vc.addressModel = model
        vc.index = index
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension AddressViewController: AddAddressDelegate{
    func ClickTheCommit(addressTabelVC: AddAddressTableViewController, flag: Int, Index: Int, model: AddressModel) {
        if flag == 1 {
            //修改数据
            addressVM.addressList[Index] = model
        }
        else{
            addressVM.addressList.append(model)
        }
        self.tableView.reloadData()
    }
}





