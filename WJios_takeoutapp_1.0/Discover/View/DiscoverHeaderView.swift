//
//  DiscoverHeaderView.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 30/11/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let collectionCellH:CGFloat = 80
private let collectionCellW:CGFloat = (kScreenW - 1) / 2
private let collectionRowNum:CGFloat = 2
private let collectionViewH:CGFloat = collectionCellH * collectionRowNum
private let lineSpace:CGFloat = 10
private let scrollViewH:CGFloat = 120
private let identifier = "discoverCell"

//delegate
protocol DiscoverCollectionViewDelegate: class {
    func ClickItem(DiscoverView: DiscoverHeaderView,Index: Int)
}

class DiscoverHeaderView: UIView {
    
    
    //MARK：- 懒加载
    //懒加载collectionview
    private lazy var collectionView: UICollectionView = {
        let rect = CGRect(x: 0, y: 0, width: kScreenW, height: collectionViewH)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionCellW, height: collectionCellH)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
        collectionView.backgroundColor = UIColor(red: 235 / 255, green: 235 / 255, blue: 235 / 255, alpha: 1)
        return collectionView
    }()

    //懒加载banner
    private lazy var banner : Banner = {
        let images = ["Snip20171119_1","Snip20171119_2","Snip20171119_3","Snip20171119_4","Snip20171119_5"]
        let rect = CGRect(x: 10, y: collectionViewH + lineSpace, width: kScreenW - 20, height: scrollViewH)
        let banner = Banner(frame: rect, images: images)
        return banner
    }()
    
    private lazy var frontView: UIView = {
        
        let rect = CGRect(x: 0, y: collectionViewH, width: kScreenW, height: lineSpace)
        let frontView = UIView(frame: rect)
        frontView.backgroundColor = UIColor.white
        return frontView
    }()
    
    private lazy var footView: UIView = {
        
        let rect = CGRect(x: 0, y: collectionViewH + lineSpace + scrollViewH, width: kScreenW, height: lineSpace)
        let footView = UIView(frame: rect)
        footView.backgroundColor = UIColor.white
        return footView
    }()

    //MARK:- 定义属性
    weak var delegate :DiscoverCollectionViewDelegate?
    
    //MARK:- 自定义初始化函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DiscoverHeaderView{
    //MARK:- 设置UI
    private func setupUI(){
        //设置collectionview
        self.addSubview(collectionView)
        //设置frontView
        self.addSubview(frontView)
        //设置banner
        self.addSubview(banner)
        //设置footView
        //self.addSubview(footView)
    }
}

extension DiscoverHeaderView: UICollectionViewDataSource,UICollectionViewDelegate{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 4
    }
    
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.bounds.size.height = 80
        cell.bounds.size.width = (kScreenW - 1) / 2
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //通知代理
        delegate?.ClickItem(DiscoverView: self, Index: indexPath.item)
    }

}

