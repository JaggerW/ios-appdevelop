//
//  PageContentView.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 06/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func PageContentViewIndex(titleView: PageContentView,lineOffsetX: CGFloat,newLabelIndex: Int)
}

private let contentCellID = "contentCellID"

class PageContentView: UIView {
    
    //MARK:- 定义属性
    private var childVcs: [UIViewController]
    private weak var parentVc: UIViewController?   //改为弱引用，防止循环引用
    private var isForbidScrollDelegate: Bool = false
    weak var delegate: PageContentViewDelegate?
    private var currentIndex:Int = 0
    
    //MARK:- 懒加载
    private lazy var collectionView: UICollectionView = { [weak self] in
        //1. 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        //2. 创建collectionview
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        
        //3. 设置代理，数据源协议
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //4. 注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        
//        let nib = UINib(nibName: "HomeHeaderCollectionViewCell", bundle: nil)
//        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
//        collectionView.backgroundColor = UIColor.white
        
        return collectionView
    }()
    
    //MARK:- 自定义构造函数
    init(frame: CGRect,childVcs: [UIViewController],parentVc: UIViewController?){
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:- 设置UI
extension PageContentView{
    private func setupUI(){
        //1. 将所有的子控制器添加到父控制器中
        for childVc in childVcs{
            parentVc?.addChildViewController(childVc)
        }
        
        //2. 添加collectionview
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK:- 遵守delegate、DataSource协议
extension PageContentView: UICollectionViewDelegate,UICollectionViewDataSource{
    //datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1. 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        
        //2. 给cell设置内容
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
    
    //delegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        let offsetX:CGFloat = collectionView.contentOffset.x
        currentIndex = Int(offsetX / kScreenW)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //判断是否是点击事件
        if isForbidScrollDelegate {return}
        //获取数据
        let offsetX = collectionView.contentOffset.x
        let lineOffsetX = offsetX / CGFloat(childVcs.count)
        let newIndex = Int((offsetX + kScreenW / 2) / kScreenW)
        //5. 通知代理
        delegate?.PageContentViewIndex(titleView: self, lineOffsetX: lineOffsetX, newLabelIndex: newIndex)
        //print("++++++")
    }
    
}

//MARK:- 对外暴露的方法
extension PageContentView{
    func setCurrentIndex(currentIndex: Int){
        isForbidScrollDelegate = true
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX,y: 0), animated: true)
    }
}
