//
//  PayFoodsViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 21/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

private let kGapW: CGFloat = 10
private let collectionCellH: CGFloat = 215
private let payViewHeaderViewID = "payViewHeaderViewID"
private let orderDetailCollectionViewCellID = "orderDetailCollectionViewCellID"
private let headerViewH: CGFloat = 160

class PayFoodsViewController: UIViewController {
    //定义属性
    var message:Int = 0
    var orderModel = OrderModel()
    var addressModel = AddressModel(){
        didSet{
            orderModel.address = addressModel.toString()
            print(orderModel.address)
        }
    }
    private lazy var orderVM : OrderViewModel = OrderViewModel()
    //MARK:- 懒加载
    private lazy var collectionCell:OrderDetailCollectionViewCell = {
        let rect = CGRect(x: 10, y: 0, width: 300, height: 260)
        let cell = OrderDetailCollectionViewCell(frame: rect)
        return cell
    }()
    //1. 懒加载collectionview
    private lazy var collectionView: UICollectionView = { [weak self] in
        //设置layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenW - 2 * kGapW, height: collectionCellH)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.headerReferenceSize = CGSize(width: kScreenW, height: headerViewH)
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        //创建collectionview
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        //设置delegate和DataSource
        collectionView.dataSource = self
        collectionView.delegate = self
        //注册cell和headerview
        collectionView.register(OrderDetailCollectionViewCell.self, forCellWithReuseIdentifier: orderDetailCollectionViewCellID)
        let headernib = UINib(nibName: "PayViewHeaderView", bundle: nil)
        collectionView.register(headernib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: payViewHeaderViewID)
        //设置collectionview的属性
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
        }()
    
    var refresh = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置ui
        setupUI()
        //添加刷新
        refresh.addTarget(self, action: #selector(refreshData), for: UIControlEvents.valueChanged)
        refresh.attributedTitle = NSAttributedString(string: "刷新")
        self.collectionView.addSubview(refresh)
        
    }
    
    @objc func refreshData(){
        self.collectionView.reloadData()
        refresh.endRefreshing()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        print("重新加载数据")
//        self.collectionView.reloadData()
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK:- 设置UI
extension PayFoodsViewController{
    private func setupUI(){
        self.view.addSubview(collectionView)
    }
}

//MARK:- 添加delegate和DataSource
extension PayFoodsViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //3个item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    //设置collectionviewcell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: orderDetailCollectionViewCellID, for: indexPath) as! OrderDetailCollectionViewCell
        //对cell进行赋值
        cell.sectionNum = indexPath.row
        cell.orderModel = orderModel
        print("为什么为什么？！")
        print(orderModel.address)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0{
            let size = CGSize(width: kScreenW - 2 * kGapW, height: CGFloat(35 + 44 * (orderModel.goodsList.count + 2) + 30))
            return size
        }
        else {
            let size = CGSize(width: kScreenW - 2 * kGapW, height: CGFloat(35 + 44 * 6 + 30))
            return size
        }
    }
    //设置headerview
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: payViewHeaderViewID, for: indexPath) as! PayViewHeaderView
        //设置代理
        header.delegate = self
        header.addressLabel.setTitle(orderModel.address, for: .normal)
        //header.backgroundColor = UIColor.red
        return header
    }
}

//MARK:- 遵守headerview的delegate
extension PayFoodsViewController: PayViewHeaderViewDelegate,AddressViewControllerDelegate{
    
    
    func ClickChooseAddress(headerView: PayViewHeaderView) {
        let story = UIStoryboard(name: "Address", bundle: nil)
        let vc = story.instantiateInitialViewController() as! AddressViewController
        vc.delegate = self
        self.navigationItem.backBarButtonItem?.title = "收货地址"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func putAddress(viewController: AddressViewController, address: String) {
        orderModel.address = address
        self.collectionView.reloadData()
    }
    
    
    func ClickPayButton(headerView: PayViewHeaderView) {
        UIAlertController.showConfirm(message: "共需支付\(orderModel.payCost)"){ (_) in
            
            //将数据提交到服务器
            //1. 将model转成字典
            var dict = [String : NSObject]()
            dict["orderId"] = self.orderModel.orderId as NSObject
            dict["orderStatus"] = self.orderModel.orderStatus as NSObject
            dict["commentFlag"] = self.orderModel.commentFlag as NSObject
            dict["storeId"] = self.orderModel.storeId as NSObject
            dict["storeName"] = self.orderModel.storeName as NSObject
            dict["orderTime"] = self.orderModel.orderTime as NSObject
            let arriveTime = self.orderModel.arriveTime ?? "正在配送中"
            dict["arriveTime"] = arriveTime as NSObject
            dict["address"] = self.orderModel.address as NSObject
            dict["deliverySide"] = self.orderModel.deliverySide as NSObject
            dict["payWay"] = self.orderModel.payWay as NSObject
            dict["deliveryCost"] = self.orderModel.deliveryCost as NSObject
            dict["preferentialPrice"] = self.orderModel.preferentialPrice as NSObject
            dict["payCost"] = self.orderModel.payCost as NSObject
            dict["userId"] = self.orderModel.userId as NSObject
            var goodsArray = [[String : NSObject]]()
            for goods in self.orderModel.goodsList{
                var dict = [String : NSObject]()
                dict["goodsName"] = goods.goodsName as NSObject
                dict["goodsCount"] = goods.orderCount as NSObject
                dict["goodsPrice"] = goods.goodsPrice as NSObject
                dict["goodsImage"] = goods.goodsImage as NSObject
                dict["orderId"] = self.orderModel.orderId as NSObject
                goodsArray.append(dict)
            }
            dict["goods"] = goodsArray as NSObject
            
            //2. 发起post网络请求
            self.orderVM.submitData(dict: dict, finishedCallback: { (flag) in
                if flag{
                    self.navigationController?.popViewController(animated: true)
                    UIAlertController.showStatus(message: "支付成功！")
                }
                else{
                    self.navigationController?.popViewController(animated: true)
                    UIAlertController.showStatus(message: "支付失败！")
                }
                
            })
            
            //转跳到订单页
            //let vc = OrderTableViewController()
            //self.navigationController?.pushViewController(vc, animated: true)
            
            //
            self.navigationController?.popViewController(animated: true)
            UIAlertController.showStatus(message: "支付成功！")
            
        }
        
    }
    
    
    
}

