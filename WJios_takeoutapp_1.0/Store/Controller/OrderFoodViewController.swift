//
//  OrderFoodViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 06/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let leftTableViewW: CGFloat = 60
private let rightTableViewW: CGFloat = kScreenW - 60
private let leftTableViewCellID = "leftTableViewCellID"
private let rightTableViewCellID = "rightTableViewCellID"
private let leftCellH: CGFloat = 40
private let leftCellW: CGFloat = leftTableViewW
private let rightCellH: CGFloat = 95
private let rightCellW: CGFloat = rightTableViewW

class OrderFoodViewController: UIViewController {
    
    //MARK:- 定义属性
    private let categoryData = ["热销","特惠","招牌系列","主食","饮品","调味剂"]
    private let foodData = [["热销商品1","热销商品2","热销商品3","热销商品4"],["特惠1","特惠2","特惠3"],["招牌1","招牌2","招牌3","招牌4","招牌5","招牌6","招牌7","招牌8"],["主食1","主食2","主食3"],["饮品1","饮品2","饮品3"],["调味1","调味2"]]
    private var selectIndex = 0
    private var isScrollDown = true
    private var lastOffsetY : CGFloat = 0.0
    
    //MARK:- 懒加载
    fileprivate lazy var leftTableView : UITableView = {
        let leftTableView = UITableView()
        leftTableView.delegate = self
        leftTableView.dataSource = self
        leftTableView.frame = CGRect(x: 0, y: 0, width: leftTableViewW, height: self.view.frame.height)
        leftTableView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        leftTableView.rowHeight = 40
        leftTableView.showsVerticalScrollIndicator = false
        leftTableView.bounces = false
        leftTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        leftTableView.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        //注册lefttableviewcell
        let nib = UINib(nibName: "LeftTableViewCell", bundle: nil)
        leftTableView.register(nib, forCellReuseIdentifier: leftTableViewCellID)
        return leftTableView
    }()
    
    fileprivate lazy var rightTableView : UITableView = {
        let rightTableView = UITableView()
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.frame = CGRect(x: leftCellW, y: 0, width: rightTableViewW, height: self.view.frame.height)
        rightTableView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        rightTableView.rowHeight = 95
        rightTableView.showsVerticalScrollIndicator = false
        rightTableView.bounces = false
        //注册righttableviewcell
        let nib = UINib(nibName: "RightTableViewCell", bundle: nil)
        rightTableView.register(nib, forCellReuseIdentifier: rightTableViewCellID)
        return rightTableView
    }()
    

    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK:- 设置UI
extension OrderFoodViewController{
    private func setupUI(){
        view.backgroundColor = UIColor.white
        
        view.addSubview(leftTableView)
        view.addSubview(rightTableView)
        
        leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
    }
}

//MARK:- 遵守delegate和DataSource协议
extension OrderFoodViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if leftTableView == tableView {
            return 1
        } else {
            return categoryData.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if leftTableView == tableView {
            return categoryData.count
        } else {
            return foodData[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if leftTableView == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: leftTableViewCellID, for: indexPath) as! LeftTableViewCell
            cell.label.text = categoryData[indexPath.row]
            cell.backgroundColor = UIColor(r: 245, g: 245, b: 245)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: rightTableViewCellID, for: indexPath) as! RightTableViewCell
            cell.foodNameLabel.text = foodData[indexPath.section][indexPath.row]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if leftTableView == tableView {
            return 0
        }
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if leftTableView == tableView {
            return nil
        }
        let headerView = RightTableHeaderView(frame: CGRect(x: 0, y: 0, width: rightTableViewW, height: 20))
        let model = categoryData[section]
        headerView.nameLabel.text = model
        return headerView
    }
    
    // TableView 分区标题即将展示
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        // 当前的 tableView 是 RightTableView，RightTableView 滚动的方向向上，RightTableView 是用户拖拽而产生滚动的（（主要判断 RightTableView 用户拖拽而滚动的，还是点击 LeftTableView 而滚动的）
        if (rightTableView == tableView)
            && !isScrollDown
            && (rightTableView.isDragging || rightTableView.isDecelerating) {
            selectRow(index: section)
        }
    }
    
    // TableView分区标题展示结束
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        // 当前的 tableView 是 RightTableView，RightTableView 滚动的方向向下，RightTableView 是用户拖拽而产生滚动的（（主要判断 RightTableView 用户拖拽而滚动的，还是点击 LeftTableView 而滚动的）
        if (rightTableView == tableView)
            && isScrollDown
            && (rightTableView.isDragging || rightTableView.isDecelerating) {
            selectRow(index: section + 1)
        }
    }
    
    // 当拖动右边 TableView 的时候，处理左边 TableView
    private func selectRow(index : Int) {
        leftTableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .top)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if leftTableView == tableView {
            selectIndex = indexPath.row
            self.scrollToTop(section: selectIndex, animated: true)
            leftTableView.scrollToRow(at: IndexPath(row: selectIndex, section: 0), at: .top, animated: true)
        }
    }
    
    fileprivate func scrollToTop(section: Int, animated: Bool) {
        let headerRect = rightTableView.rect(forSection:section)
        let topOfHeader = CGPoint(x: 0, y: headerRect.origin.y - rightTableView.contentInset.top)
        rightTableView.setContentOffset(topOfHeader, animated: animated)
    }
    
    // 标记一下 RightTableView 的滚动方向，是向上还是向下
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let tableView = scrollView as! UITableView
        if rightTableView == tableView {
            isScrollDown = lastOffsetY < scrollView.contentOffset.y
            lastOffsetY = scrollView.contentOffset.y
        }
    }
}

















