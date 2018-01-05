//
//  OrderFoodViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 06/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit
import SnapKit


private let leftTableViewW: CGFloat = 60
private let rightTableViewW: CGFloat = kScreenW - 60
private let leftTableViewCellID = "leftTableViewCellID"
private let rightTableViewCellID = "rightTableViewCellID"
private let goodsListTableViewCellID = "goodsListTableViewCellID"
private let leftCellH: CGFloat = 40
private let leftCellW: CGFloat = leftTableViewW
private let rightCellH: CGFloat = 95
private let rightCellW: CGFloat = rightTableViewW
private let kShoppingCartH: CGFloat = 60
private let popTableViewH: CGFloat = 160

class OrderFoodViewController: UIViewController {
    
    //MARK:- 定义属性
    private let categoryData = ["热销","特惠","招牌系列","主食","饮品","调味剂"]
    private let foodData = [["热销商品1","热销商品2","热销商品3","热销商品4","热销商品5"],["特惠1","特惠2","特惠3"],["招牌1","招牌2","招牌3","招牌4","招牌5","招牌6","招牌7","招牌8"],["主食1","主食2","主食3"],["饮品1","饮品2","饮品3"],["调味1","调味2"]]
    
    private var selectIndex = 0
    private var isScrollDown = true
    private var lastOffsetY : CGFloat = 0.0
    //shopcart属性
    private var currentCost: Int = 0
    private var qisongPrice: Int = 0
    private var haichaPrice: Int = 0
    
    //goodslist属性
    private var foodNumString = [Int]()
    private var foodNameString = [String]()
    private var count : Int = 0
    private var clickShopCartFlag: Int = 0
    //MARK:- 懒加载
    fileprivate lazy var leftTableView : UITableView = {
        let leftTableView = UITableView()
        leftTableView.delegate = self
        leftTableView.dataSource = self
        leftTableView.frame = CGRect(x: 0, y: 0, width: leftTableViewW, height: self.view.frame.height - kShoppingCartH)
        leftTableView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        //leftTableView.contentInset.bottom = 60
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
        rightTableView.frame = CGRect(x: leftCellW, y: 0, width: rightTableViewW, height: self.view.frame.height - kShoppingCartH)
        rightTableView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        //rightTableView.contentInset.bottom = 60
        rightTableView.rowHeight = 95
        rightTableView.showsVerticalScrollIndicator = false
        rightTableView.bounces = false
        //注册righttableviewcell
        let nib = UINib(nibName: "RightTableViewCell", bundle: nil)
        rightTableView.register(nib, forCellReuseIdentifier: rightTableViewCellID)
        return rightTableView
    }()
    
    //懒加载shoppingcart
    private lazy var shoppingCart: ShoppingCart = {
       
        let cart = ShoppingCart(frame: CGRect.zero)
        cart.delegate = self
        return cart
    }()
    
    //懒加载popView
    private lazy var popView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.purple
        return view
    }()
    
    //懒加载poptableview
    private lazy var popTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        //delegate
        tableView.delegate = self
        tableView.dataSource = self
        //注册cell
        let nib = UINib(nibName: "GoodsListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: goodsListTableViewCellID)
        return tableView
    }()
    
    //懒加载maskView
    private lazy var maskView: UIView = {
        let rect = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - kShoppingCartH)
        let view = UIView(frame: rect)
        view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        view.isHidden = true
        
        //给cartView添加手势
        view.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.MaskViewClick(tapGes:)))
        view.addGestureRecognizer(tapGes)
        
        
        return view
    }()

    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI
        setupUI()
        currentCost = 0
        qisongPrice = 20
        haichaPrice = 0
        clickShopCartFlag = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func MaskViewClick(tapGes: UITapGestureRecognizer){
        //隐藏
        hide()
    }

}

//MARK:- 设置UI
extension OrderFoodViewController{
    private func setupUI(){
        view.backgroundColor = UIColor.white
        //view.addSubview(shoppingCart)
        view.addSubview(leftTableView)
        view.addSubview(rightTableView)
        view.addSubview(shoppingCart)
        view.addSubview(maskView)
        popTableView.frame = CGRect(x: 0, y: maskView.frame.height, width: maskView.frame.width, height: popTableViewH)
        maskView.addSubview(popTableView)
        //布局
        shoppingCart.snp.makeConstraints { (make) in
            make.height.equalTo(60)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.top.equalTo(rightTableView.snp.bottom).offset(0)
        }
//        popTableView.snp.makeConstraints { (make) in
//            make.height.equalTo(160)
//            make.left.equalToSuperview().offset(0)
//            make.right.equalToSuperview().offset(0)
//            make.top.equalTo(shoppingCart.snp.bottom).offset(0)
//        }
        
        
        leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
    }
}

//MARK:- 遵守delegate和DataSource协议
extension OrderFoodViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if leftTableView == tableView {
            return 1
        }
        else if rightTableView == tableView  {
            return categoryData.count
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if leftTableView == tableView {
            return categoryData.count
        }
        else if rightTableView == tableView {
            return foodData[section].count
        }
        else {
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if leftTableView == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: leftTableViewCellID, for: indexPath) as! LeftTableViewCell
            cell.label.text = categoryData[indexPath.row]
            cell.backgroundColor = UIColor(r: 245, g: 245, b: 245)
            return cell
        }
        else if rightTableView == tableView {
            
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: rightTableViewCellID) as! RightTableViewCell
            
//            if (cell == nil) {
//                cell = RightTableViewCell(style: .default, reuseIdentifier: rightTableViewCellID)
//            }
//            else{
//                //判断cell中如果有自视图则移除
//                while (cell?.contentView.subviews.last != nil){
//                    cell?.contentView.subviews.last?.removeFromSuperview()
//                }
//            }
            if cell.numArray[indexPath.section][indexPath.row] == 0 {
                cell.foodNameLabel.text = "0"
                cell.foodNumLabel.isHidden = true
                cell.subBtn.isHidden = true
                cell.subBtn.isEnabled = false
            }
            else {
                cell.foodNumLabel.text = String(cell.numArray[indexPath.section][indexPath.row])
                cell.foodNumLabel.isHidden = false
                cell.subBtn.isHidden = false
                cell.subBtn.isEnabled = true
            }
            
            cell.foodNameLabel.text = foodData[indexPath.section][indexPath.row]
            cell.addBtn.tag = indexPath.row + (indexPath.section * 10)
            cell.subBtn.tag = indexPath.row + (indexPath.section * 10)
            //给righttableview添加代理
            cell.delegate = self
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: goodsListTableViewCellID, for: indexPath) as! GoodsListTableViewCell
            //添加代理
            cell.GoodsNameLabel.text = foodNameString[indexPath.row]
            cell.GoodsNumLabel.text = String(foodNumString[indexPath.row])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if rightTableView == tableView {
            return 20
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if rightTableView == tableView {
            let headerView = RightTableHeaderView(frame: CGRect(x: 0, y: 0, width: rightTableViewW, height: 20))
            let model = categoryData[section]
            headerView.nameLabel.text = model
            return headerView
        }
        return nil
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

//MARK:- 遵守orderfooddelegate
extension OrderFoodViewController:OrderFoodDelegate{
    
    
    func ClickAddButton(tableViewCell: RightTableViewCell, goodsNum: Int, goodsPrice: Int, foodName: String) {
        let price = goodsPrice
        currentCost += price
        if goodsNum == 1 {
            count += 1
            foodNameString.append(foodName)
            foodNumString.append(goodsNum)
            //popTableView.reloadData()
        }
        else {
            
            foodNumString[count - 1] = goodsNum
            //popTableView.reloadData()
        }
        if currentCost >= qisongPrice{
            //调用shopcart对外暴露函数进行相关设置
            shoppingCart.setupPay(currentPrice: currentCost)
        }
        else{
            haichaPrice = qisongPrice - currentCost
            //调用shopcart对外暴露函数进行相关设置
            shoppingCart.setupContinueAdd(currentPrice: currentCost, haichaPrice: haichaPrice)
        }
    }
    
    func ClickSubButton(tableViewCell: RightTableViewCell, goodsNum: Int, goodsPrice: Int) {
        let price = goodsPrice
        currentCost -= price
        
        if goodsNum == 0{
            count -= 1
            popTableView.reloadData()
        }
        
        if currentCost >= qisongPrice{
            //调用shopcart对外暴露函数进行相关设置
            shoppingCart.setupPay(currentPrice: currentCost)
        }
        else if currentCost == 0{
            
            //调用shopcart对外暴露函数进行相关设置
            shoppingCart.setupInit()
        }
            
        else{
            haichaPrice = qisongPrice - currentCost
            //调用shopcart对外暴露函数进行相关设置
            shoppingCart.setupContinueAdd(currentPrice: currentCost, haichaPrice: haichaPrice)
        }
    }
    
    
}

//MARK:- 遵守shoppingcartdelegate
extension OrderFoodViewController:ShoppingCartDelegate{
    func ClickPayButton(View: ShoppingCart) {
        print(currentCost)
    }
    
    func ClickCartView(View: ShoppingCart) {
        //弹出
        if (clickShopCartFlag == 0) && (currentCost != 0){
            
            show()
            //clickShopCartFlag = 1
        }
        //隐藏
        else if (clickShopCartFlag == 1) && (currentCost != 0){
            
            hide()
            //clickShopCartFlag = 0
        }
        
        
    }
}

//MARK:- 扩充函数
extension OrderFoodViewController{
    private func show(){
        popTableView.reloadData()
        UIView.animate(withDuration: 0.3, animations: {
            self.maskView.isHidden = false
            self.popTableView.frame.origin.y = self.maskView.frame.height - popTableViewH
        })
        clickShopCartFlag = 1
    }
    private func hide(){
        UIView.animate(withDuration: 0.3, animations: {
            self.popTableView.frame.origin.y = self.maskView.frame.height
            self.maskView.isHidden = true
        })
        clickShopCartFlag = 0
    }
}

















