//
//  StoreVouchersViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 21/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40
private let collectionViewH: CGFloat = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH
private let collectionViewW: CGFloat = kScreenW
private let kGap: CGFloat = 10
private let collectionCellW: CGFloat = (kScreenW - kGap * 3) / 2
private let collectionCellH: CGFloat = collectionCellW
private let cellID = "PreciousCollectionCellID"

class StoreVouchersViewController: UIViewController {
    
    //MARK:- 懒加载
    //懒加载collectionview
    private lazy var collectionView: UICollectionView = {
        let rect = CGRect(x: 0, y: 0, width: kScreenW, height: collectionViewH)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionCellW, height: collectionCellH)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        //创建collectionview
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        collectionView.contentInset.left = 10
        collectionView.contentInset.right = 10
        //设置代理
        collectionView.dataSource = self
        collectionView.delegate = self
        //注册cell
        let nib = UINib(nibName: "PreciousCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellID)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置ui
        self.view.addSubview(collectionView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

//MARK:- 遵守collectionview的delegate和DataSource
extension StoreVouchersViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 12
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PreciousCollectionViewCell
//        cell.bounds.size.height = 80
//        cell.bounds.size.width = (kScreenW - 1) / 2
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "Precious", bundle: nil).instantiateInitialViewController() as!PreciousTableViewController
        self.navigationItem.backBarButtonItem?.title = "代金券"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
