//
//  GroupPurchaseViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 21/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let kHeaderViewH: CGFloat = 0
private let kTitleViewH: CGFloat = 40

class GroupPurchaseViewController: UIViewController {
    //MARK:- 懒加载
    //懒加载pagetitleview
    private lazy var pageTitleView: PageTitleView = { [weak self] in
        let titleframe = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kHeaderViewH, width: kScreenW, height: kTitleViewH)
        let titles = ["商家代金券","其他商品"]
        let titleView = PageTitleView(frame: titleframe, titles: titles)
        titleView.delegate = self
        return titleView
        }()
    
    //懒加载pagecontentview
    private lazy var pageContentView: PageContentView = { [weak self] in
        
        //1. 确定frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kHeaderViewH
        let frame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH + kHeaderViewH, width: kScreenW, height: contentH)
        
        //2.确定所有的子控制器
        var childVcs = [UIViewController]()
        
        childVcs.append(StoreVouchersViewController())
        childVcs.append(OtherViewController())
        
        let contentView = PageContentView(frame: frame, childVcs: childVcs, parentVc: self)
        contentView.delegate = self
        return contentView
        }()
    
    //MARK:- 定义属性

    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

//MARK:- 设置ui
extension GroupPurchaseViewController{
    private func setupUI(){
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(pageTitleView)
        self.view.addSubview(pageContentView)
    }
}

//MARK:- 遵守pagetitleviewdelegate协议
extension GroupPurchaseViewController: PageTitleViewDelegate{
    func pageTitleViewIndex(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//MARK:- 遵守pagecontentviewdelegate
extension GroupPurchaseViewController: PageContentViewDelegate{
    
    func PageContentViewIndex(titleView: PageContentView, lineOffsetX: CGFloat, newLabelIndex: Int) {
        //print("-------")
        pageTitleView.setPageTitleView(lineOffsetX: lineOffsetX, newLabelIndex: newLabelIndex)
    }
}

