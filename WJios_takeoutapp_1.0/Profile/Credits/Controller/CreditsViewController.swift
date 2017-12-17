//
//  CreditsViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 13/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let collectionViewH: CGFloat = kScreenH
private let headerViewH: CGFloat = 160
private let itemGap: CGFloat = 10
private let collectionCellH: CGFloat = 90
private let collectionCellW: CGFloat = kScreenW - 2 * itemGap
private let discountCollectionViewCellID = "discountCollectionViewCellID"
private let creditsHeaderViewID = "creditsHeaderViewID"

class CreditsViewController: UIViewController {
    
    //MARK:- 懒加载
    //1. 懒加载collectionview
    private lazy var collectionView: UICollectionView = {
        //设置layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionCellW, height: collectionCellH)
        layout.minimumLineSpacing = itemGap
        layout.minimumInteritemSpacing = itemGap
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        layout.headerReferenceSize = CGSize(width: kScreenW, height: headerViewH)
        
        //创建collectionview
        let rect = CGRect(x: 0, y: 0, width: kScreenW, height: collectionViewH)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        
        //设置delegate和DataSource
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //注册cell
        let nib = UINib(nibName: "DiscountCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: discountCollectionViewCellID)
        let headernib = UINib(nibName: "CreditsHeaderView", bundle: nil)
        collectionView.register(headernib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: creditsHeaderViewID) 
        
        
        //设置collectionview属性
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(collectionView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

//MARK:- collectionview的delegate和datasource
extension CreditsViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: discountCollectionViewCellID, for: indexPath) as! DiscountCollectionViewCell
        
        cell.button.setTitle("兑换", for: .normal)
        cell.creditsCost.text = "150 金币"
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: creditsHeaderViewID, for: indexPath) as! CreditsHeaderView
        
        return header
        
    }
}
