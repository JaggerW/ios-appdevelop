//
//  AddAddressTableViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 14/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

protocol AddAddressDelegate : class {
    func ClickTheCommit(addressTabelVC : AddAddressTableViewController, flag : Int, Index : Int, model: AddressModel)
}

class AddAddressTableViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var addressLabel: UITextField!
    @IBOutlet weak var doorLabel: UITextField!
    @IBOutlet weak var telLabel: UITextField!
    //添加手势
    @IBOutlet weak var openMap: UIImageView!
    //地址模型
    var addressModel = AddressModel(){
        didSet{
            flag = 1
        }
    }
    var index : Int = 0
    var delegate : AddAddressDelegate?
    private lazy var addressVM = AddressViewModel()
    //flag=0:提交新的数据   1:修改已有数据
    private var flag : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        if flag == 1{
            nameLabel.text = addressModel.userName
            addressLabel.text = addressModel.address
            telLabel.text = addressModel.userTel
        }
        
        openMap.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.openMap(tapGes:)))
        openMap.addGestureRecognizer(tapGes)
        
    }
    
    @objc private func openMap(tapGes: UITapGestureRecognizer){
        //通知代理
        let vc = UIStoryboard(name: "Map", bundle: nil).instantiateInitialViewController() as! MapViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    @IBAction func Commit(_ sender: Any) {
        //模型转字典
        var dict = [String : NSObject]()
        dict["userId"] = USERID as NSObject
        dict["userName"] = nameLabel.text! as NSObject
        if doorLabel.text != nil {
            dict["address"] = addressLabel.text! + doorLabel.text! as NSObject
        }
        else{
            dict["address"] = addressLabel.text! as NSObject
        }
        dict["userTel"] = telLabel.text! as NSObject
        
        //上传至服务器
        if flag == 1{
            //modify
            dict["addressId"] = addressModel.addressId as NSObject
            addressVM.updateData(dict: dict, finishedCallback: { (a) in
                self.flag = 0
                if a{
                    UIAlertController.showStatus(message: "地址信息修改成功")
                }
                else{
                    UIAlertController.showStatus(message: "地址信息修改失败")
                }
            })
        }
        else{
            addressVM.submitData(dict: dict, finishedCallback: { (a) in
                if a{
                    UIAlertController.showStatus(message: "地址信息添加成功")
                }
                else{
                    UIAlertController.showStatus(message: "地址信息添加失败")
                }
            })
        }
        //通知代理，提交数据
        let model = AddressModel(dict: dict)
        self.delegate?.ClickTheCommit(addressTabelVC: self, flag: flag, Index: index, model: model)
        //返回上一级，重新加载页面
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 75
        }
        else {
            return 44
        }
    }
    
}

extension AddAddressTableViewController: MapViewDelegate{
    func ClickTheCommit(mapView: MapViewController, address: String) {
        addressLabel.text = address
    }
}













