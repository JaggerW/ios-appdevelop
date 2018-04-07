//
//  OrderDetailViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 10/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let kGapW: CGFloat = 10
private let collectionCellH: CGFloat = 215
private let orderDetailHeaderViewID = "orderDetailHeaderViewID"
private let orderDetailCollectionViewCellID = "orderDetailCollectionViewCellID"
private let headerViewH: CGFloat = 160

class OrderDetailViewController: UIViewController {
    
    //定义属性
    var message: String = ""
    var orderModel = OrderModel()
    //private lazy var orderVM : OrderViewModel = OrderViewModel()
    //private lazy var orderDetailVM: OrderDetailViewModel = OrderDetailViewModel()
    
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
//        let nib = UINib(nibName: "OrderDetailCollectionViewCell", bundle: nil)
//        collectionView.register(nib, forCellWithReuseIdentifier: orderDetailCollectionViewCellID)
        collectionView.register(OrderDetailCollectionViewCell.self, forCellWithReuseIdentifier: orderDetailCollectionViewCellID)
        let headernib = UINib(nibName: "OrderDetailHeaderView", bundle: nil)
        collectionView.register(headernib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: orderDetailHeaderViewID)
        //设置collectionview的属性
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        collectionView.showsVerticalScrollIndicator = false
        

        return collectionView
    }()

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
extension OrderDetailViewController{
    private func setupUI(){
        self.view.addSubview(collectionView)
    }
}

//MARK:- 添加delegate和DataSource
extension OrderDetailViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: orderDetailHeaderViewID, for: indexPath) as! OrderDetailHeaderView
        header.delegate = self
        
        //header.backgroundColor = UIColor.red
        return header
    }
}

//MARK:- 遵守headerview的delegate
extension OrderDetailViewController: OrderDetailHeaderDelegate{
    func ClickTheButton(headerView: OrderDetailHeaderView) {
        print(message)
        let storyBoard = UIStoryboard(name: "Store", bundle: nil)
        let vc = storyBoard.instantiateInitialViewController()!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func ClickCommentButton(headerView: OrderDetailHeaderView) {
        if orderModel.orderStatus == 1{
            if orderModel.commentFlag == 0{
                let vc = UIStoryboard(name: "Store", bundle: nil).instantiateViewController(withIdentifier: "CommentStoryBoardID") as! CommentCaseViewController
                vc.orderModel = orderModel
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                UIAlertController.showStatus(message: "您已评论过该订单，不可重复评论")
            }
        }
        else {
            UIAlertController.showStatus(message: "该订单未完成!")
        }
    }

}












