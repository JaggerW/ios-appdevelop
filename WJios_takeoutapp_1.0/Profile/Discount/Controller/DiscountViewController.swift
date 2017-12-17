//
//  DiscountViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 13/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let collectionViewH: CGFloat = kScreenH
private let itemGap: CGFloat = 10
private let collectionCellH: CGFloat = 90
private let collectionCellW: CGFloat = kScreenW - 2 * itemGap
private let discountCollectionViewCellID = "discountCollectionViewCellID"



class DiscountViewController: UIViewController {
    //MARK:- 懒加载
    //1. 懒加载collectionview
    private lazy var collectionView: UICollectionView = {
        //设置layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionCellW, height: collectionCellH)
        layout.minimumLineSpacing = itemGap
        layout.minimumInteritemSpacing = itemGap
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        //创建collectionview
        let rect = CGRect(x: 0, y: 0, width: kScreenW, height: collectionViewH)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        
        //设置delegate和DataSource
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //注册cell
        let nib = UINib(nibName: "DiscountCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: discountCollectionViewCellID)
        
        //设置collectionview属性
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        return collectionView
    }()
    
    //MARK:- 定义属性
    var count: Int = 0
    

    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        //添加collectionview
        self.view.addSubview(collectionView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK:- 设置delegate和DataSource
extension DiscountViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: discountCollectionViewCellID, for: indexPath) as! DiscountCollectionViewCell
        cell.StoreID = indexPath.item
        cell.delegate = self
        return cell
    }
    
}

//MARK:- 设置cell的delegate
extension DiscountViewController: DiscountCollectionViewCellDelegate{
    func ClickTheButton(viewCell: DiscountCollectionViewCell, StoreID: Int) {
        print(StoreID)
        let story = UIStoryboard(name: "Store", bundle: nil)
        let vc = story.instantiateInitialViewController()!
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


















