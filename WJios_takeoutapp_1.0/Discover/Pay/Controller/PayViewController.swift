//
//  PayViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 19/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let kHeaderViewH: CGFloat = 0
private let kTitleViewH:CGFloat = 40


class PayViewController: UIViewController {
    
    //MARK:- 懒加载
    //懒加载pagetitleview
    private lazy var pageTitleView: PageTitleView = { [weak self] in
        let titleframe = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kHeaderViewH, width: kScreenW, height: kTitleViewH)
        let titles = ["电费","网费","话费"]
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
        
        let elecVC = UIStoryboard(name: "Pay", bundle: nil).instantiateViewController(withIdentifier: "ElectricPayStoryBoardID") as! ElecPayViewController
        let netVC = UIStoryboard(name: "Pay", bundle: nil).instantiateViewController(withIdentifier: "NetPayStoryBoardID") as! NetPayViewController
        let phoneVC = UIStoryboard(name: "Pay", bundle: nil).instantiateViewController(withIdentifier: "PhonePayStoryBoardID") as! PhonePayViewController
//        let phoneFlowVC = UIStoryboard(name: "Pay", bundle: nil).instantiateViewController(withIdentifier: "PhoneFlowPayStoryBoardID") as! PhoneFlowPayViewController
        childVcs.append(elecVC)
        childVcs.append(netVC)
        childVcs.append(phoneVC)
//        childVcs.append(phoneFlowVC)
        
        let contentView = PageContentView(frame: frame, childVcs: childVcs, parentVc: self)
        contentView.delegate = self
        return contentView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置ui
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(pageTitleView)
        self.view.addSubview(pageContentView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

}

//MARK:- 遵守pagetitleviewdelegate协议
extension PayViewController: PageTitleViewDelegate{
    func pageTitleViewIndex(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//MARK:- 遵守pagecontentviewdelegate
extension PayViewController: PageContentViewDelegate{
    
    func PageContentViewIndex(titleView: PageContentView, lineOffsetX: CGFloat, newLabelIndex: Int) {
        //print("-------")
        pageTitleView.setPageTitleView(lineOffsetX: lineOffsetX, newLabelIndex: newLabelIndex)
    }
}
