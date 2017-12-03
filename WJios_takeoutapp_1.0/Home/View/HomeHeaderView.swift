//
//  HomeHeaderView.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 01/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let collectionCellH:CGFloat = 80
private let collectionCellW:CGFloat = kScreenW / 4
private let collectionRowNum:CGFloat = 2
private let collectionViewH:CGFloat = collectionRowNum * collectionCellH
private let bannerH:CGFloat = 120
private let bannerX:CGFloat = 10
private let linetextH:CGFloat = 40
private let identifier = "homeHeaderCell"
class HomeHeaderView: UIView {
    
    //MARK:- 懒加载
    //1. 懒加载collectionview
    private lazy var collectionView: UICollectionView = {
        let rect = CGRect(x: 0, y: 0, width: kScreenW, height: collectionViewH)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionCellW, height: collectionCellH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "HomeHeaderCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    //2. 懒加载banner视图
    private lazy var banner: Banner = {
        
        let bannerframe = CGRect(x: bannerX, y: collectionViewH, width: kScreenW - bannerX * 2, height: bannerH)
        let images = ["Snip20171119_1","Snip20171119_2","Snip20171119_3","Snip20171119_4","Snip20171119_5"]
        let banner = Banner(frame: bannerframe, images: images)
        return banner
    }()
    //3. 懒加载lineText视图
    private lazy var linetext:lineText = {
        let rect = CGRect(x: 0, y: collectionViewH + bannerH, width: kScreenW, height: linetextH)
        let linetext = lineText(frame: rect)
        return linetext
    }()
    
    //MARK:- 自定义构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:- 设置UI
extension HomeHeaderView{
    private func setupUI(){
        //1. 添加collectionview
        self.addSubview(collectionView)
        //2. 添加banner
        self.addSubview(banner)
        //3. 添加linetext
        self.addSubview(linetext)
    }
}

//MARK:- 设置collectionview的delegate和DataSource
extension HomeHeaderView:UICollectionViewDelegate,UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 8
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.bounds.size.width = collectionCellW
        cell.bounds.size.height = collectionCellH
        return cell
    }
}

















