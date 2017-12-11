//
//  StoreViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 05/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40
private let kHeaderViewH: CGFloat = 145
class StoreViewController: UIViewController {
    
    //MARK:- 懒加载
    //懒加载headerview
    private lazy var storeHeaderView: StoreHeaderView = {
        let rect = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kHeaderViewH)
        let storeheaderview = StoreHeaderView(frame: rect)
        return storeheaderview
    }()
    
    //懒加载pagetitleview
    private lazy var pageTitleView: PageTitleView = { [weak self] in
        let titleframe = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kHeaderViewH, width: kScreenW, height: kTitleViewH)
        let titles = ["点餐","评价","详情"]
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
        childVcs.append(OrderFoodViewController())
        childVcs.append(CommentViewController())
        childVcs.append(DetailViewController())
//        let detailVc = UIStoryboard(name: "Detail", bundle: nil).instantiateInitialViewController()!
//        childVcs.append(detailVc)
//        for _ in 0..<1{
//            let vc = UIViewController()
//            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
//            childVcs.append(vc)
//        }
        
        let contentView = PageContentView(frame: frame, childVcs: childVcs, parentVc: self)
        contentView.delegate = self
        return contentView
    }()
    
    //懒加载left、righttableview
    
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI
        setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK:- 设置UI
extension StoreViewController{
    
    private func setupUI(){

        //1. 设置navigationbar
        setupNavBar()
        
        //2. 添加headerview
        view.addSubview(storeHeaderView)
        
        //3. 添加titleview
        view.addSubview(pageTitleView)
        
        //4. 添加contentview
        view.addSubview(pageContentView)
        
    }
    
    private func setupNavBar(){
     
        //1. 设置右侧的item
        let size = CGSize(width: 40, height: 40)
        let searchItem = UIBarButtonItem(imageName: "shopping_shop_nav_search", highImageName: "", size: size)
        let shopcartItem = UIBarButtonItem(imageName: "esc_shop_icon_cart", highImageName: "", size: size)
        navigationItem.rightBarButtonItems = [searchItem,shopcartItem]
    }
}

//MARK:- 遵守pagetitleviewdelegate协议
extension StoreViewController: PageTitleViewDelegate{
    func pageTitleViewIndex(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//MARK:- 遵守pagecontentviewdelegate
extension StoreViewController: PageContentViewDelegate{
    
    func PageContentViewIndex(titleView: PageContentView, lineOffsetX: CGFloat, newLabelIndex: Int) {
        //print("-------")
        pageTitleView.setPageTitleView(lineOffsetX: lineOffsetX, newLabelIndex: newLabelIndex)
    }
}










