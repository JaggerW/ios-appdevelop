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

protocol StoreDelegate :class {
    func findGoods(viewController : StoreViewController, indexpath : IndexPath)
}

class StoreViewController: UIViewController {
    
    var store_tag: Int = 0
    var store_id: Int = 0
    var storeModel : StoreListModel = StoreListModel()
    
    weak var delegate : StoreDelegate?
    
    //MARK:- 懒加载
    private lazy var storeListVM: ListStoreViewModel = ListStoreViewModel()
    private lazy var goodsListVM: ListGoodsViewModel = ListGoodsViewModel()
    private lazy var goodsAarry : [String] = []
    private lazy var goodsIndexPath : [IndexPath] = []
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
        //对自控制器通过属性赋值进行值传递
        
        let ofVC = OrderFoodViewController()
        ofVC.storeId = store_id
        ofVC.storeModel = storeListVM.store
        childVcs.append(ofVC)
        
        let cVC = CommentViewController()
        cVC.storeId = store_id
        cVC.storeGrade = storeListVM.store.storeGrade
        cVC.salesAmount = storeListVM.store.salesAmount
        childVcs.append(cVC)
        
        let dVC = DetailViewController()
        dVC.storeModel = storeListVM.store 
        childVcs.append(dVC)
        
        let contentView = PageContentView(frame: frame, childVcs: childVcs, parentVc: self)
        contentView.delegate = self
        return contentView
    }()
    
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
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
     
        let searchItem = UIBarButtonItem(image: UIImage(named: "shopping_shop_nav_search"), style: .plain, target: self, action: #selector(self.searchFood))
        
        navigationItem.rightBarButtonItem = searchItem
    }
    
    @objc private func searchFood(){
        let vc = UIStoryboard(name: "Store", bundle: nil).instantiateViewController(withIdentifier: "SearchFoodStoryBoard") as! SearchGoodsViewController
        vc.delegate = self
        //传送数据
        vc.goodsIndexPath = goodsIndexPath
        vc.goods = goodsAarry
        //push控制器
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    private func loadData(){
        storeListVM.requestData(parameters: store_id) {
            self.storeHeaderView.store = self.storeListVM.store
            self.setupUI()
        }
        
        goodsListVM.requestData(storeId: store_id) {
            for group in 0..<self.goodsListVM.goodsGroups.count{
                for goods in 0..<self.goodsListVM.goodsGroups[group].goods.count{
                    self.goodsAarry.append(self.goodsListVM.goodsGroups[group].goods[goods].goodsName)
                    let indexPath = IndexPath.init(row: goods, section: group)
                    self.goodsIndexPath.append(indexPath)
                }
            }
        }
        
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
        
        pageTitleView.setPageTitleView(lineOffsetX: lineOffsetX, newLabelIndex: newLabelIndex)
    }
}

extension StoreViewController: SearchGoodsDelegate{
    func findGoods(viewController: SearchGoodsViewController, indexpath: IndexPath) {
        print(indexpath)
        //通知代理
        //self.delegate?.findGoods(viewController: self, indexpath: indexpath)
        let vc = OrderFoodViewController()
        vc.indexpath = indexpath
    }
}










