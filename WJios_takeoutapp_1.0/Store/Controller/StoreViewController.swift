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
private let kShoppingCartH: CGFloat = 60
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
        
        let contentView = PageContentView(frame: frame, childVcs: childVcs, parentVc: self)
        contentView.delegate = self
        return contentView
    }()
    
    //懒加载left、righttableview
    
    //懒加载shopcartView
    private lazy var shopCartView: ShopCartView = {
        let view = ShopCartView(frame: self.view.bounds)
        return view
    }()
    
    
    
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI
        setupUI()
        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(self.show(notification:)), name: Notification.Name("ShowView"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(hide), name: HideView, object: nil)
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    deinit {
        //记得移除通知监听
        NotificationCenter.default.removeObserver(self)
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
        
        //5. 添加shopCartView
        //view.addSubview(shopCartView)
        
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

extension StoreViewController{
    @objc private func show(notification:NSNotification){
        shopCartView.showView()
    }
    @objc private func hide(){
        
    }
    
    
}











