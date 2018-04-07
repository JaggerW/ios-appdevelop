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
private var popTableViewH: CGFloat = 44 * 3
private let popHeaderViewH: CGFloat = 32

class OrderFoodViewController: UIViewController {
    //定义属性，获取上一页面传递过来的storemodel数据
    var storeModel : StoreListModel = StoreListModel(){
        didSet{
            shoppingCart.sendingPrice = storeModel.sendingPrice
            shoppingCart.deliveryCost = storeModel.deliveryCost
        }
    }
    var storeId : Int = 0
    
    var indexpath : IndexPath = IndexPath.init(row: 0, section: 0){
        didSet{
            print(indexpath)
            //setupUI()
            //loadData()
        }
    }
    //懒加载goodsListVM，请求数据保存数据
    private lazy var goodsListVM: ListGoodsViewModel = ListGoodsViewModel()
    private lazy var storeVM: ListStoreViewModel = ListStoreViewModel()
    //定义属性，作为订单数组
    lazy var orderArray : [GoodsModel] = [GoodsModel]()
    
    //MARK:- 定义属性
    
    private var selectIndex = 0
    private var isScrollDown = true
    private var lastOffsetY : CGFloat = 0.0
    //shopcart属性
    private var currentCost: Float = 0
    private var totalPrice: Float = 0
    private var qisongPrice: Float = 0
    private var haichaPrice: Float = 0
    
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
//        cart.sendingPrice = storeModel.sendingPrice
//        cart.deliveryCost = storeModel.deliveryCost
        cart.delegate = self
        return cart
    }()
    private lazy var popHeaderView: UIView = {
        let rect = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 32)
        let headerView = UIView(frame: rect)
        headerView.backgroundColor = UIColor.groupTableViewBackground
        return headerView
    }()
    private lazy var label: UILabel = {
        let rect = CGRect(x: 0, y: 0, width: 84, height: 24)
        let label = UILabel(frame: rect)
        label.text = "已选商品"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    private lazy var emptyBtn: UIButton = {
        let rect = CGRect(x: 0, y: 0, width: 84, height: 24)
        let btn = UIButton(frame: rect)
        btn.setImage(UIImage(named: "address_search_delete"), for: .normal)
        btn.backgroundColor = UIColor.groupTableViewBackground
        btn.addTarget(self, action: #selector(emptyOrderArray),  for: .touchUpInside)
        return btn
    }()
    //懒加载popView
    private lazy var popView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        return view
    }()
    
    //懒加载poptableview
    private lazy var popTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        tableView.showsVerticalScrollIndicator = true
        tableView.bounces = false
        tableView.rowHeight = 44
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
        currentCost = 0
        clickShopCartFlag = 0
        //设置UI
        setupUI()
        loadData()
        //设置属性初始值
        let vc = UIStoryboard(name: "Store", bundle: nil).instantiateInitialViewController() as! StoreViewController
        vc.delegate = self
        //
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }
    
    @objc private func MaskViewClick(tapGes: UITapGestureRecognizer){
        //隐藏
        hide()
    }

}

//MARK:- 设置UI
extension OrderFoodViewController{
    
    //MARK:- 设置UI
    private func setupUI(){
        view.backgroundColor = UIColor.white
        view.addSubview(leftTableView)
        view.addSubview(rightTableView)
        view.addSubview(shoppingCart)
        view.addSubview(maskView)
        popHeaderView.addSubview(label)
        popHeaderView.addSubview(emptyBtn)
        popView.frame = CGRect(x: 0, y: maskView.frame.height, width: maskView.frame.width, height: popHeaderViewH + popTableViewH)
        popView.addSubview(popHeaderView)
        popTableView.frame = CGRect(x: 0, y: popHeaderViewH, width: maskView.frame.width, height: popTableViewH)
        popView.addSubview(popTableView)
        maskView.addSubview(popView)
        //布局
        shoppingCart.snp.makeConstraints { (make) in
            make.height.equalTo(60)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.top.equalTo(rightTableView.snp.bottom).offset(0)
        }
        popHeaderView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.height.equalTo(32)
        }
        label.snp.makeConstraints { (make) in
            make.height.equalTo(21)
            make.width.equalTo(58)
            make.top.equalToSuperview().offset(6)
            make.left.equalToSuperview().offset(14)
        }
        emptyBtn.snp.makeConstraints { (make) in
            make.height.equalTo(22)
            make.width.equalTo(53)
            make.top.equalToSuperview().offset(6)
            make.right.equalToSuperview().offset(0)
        }
        
        leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
    }
    
    //MARK:- 加载数据
    private func loadData(){
        goodsListVM.requestData(storeId: storeId) {
            self.leftTableView.reloadData()
            self.rightTableView.reloadData()
            print(self.indexpath)
            if self.indexpath != [0,0]{
                let headerRect = self.rightTableView.rectForRow(at: self.indexpath)
                let topOfHeader = CGPoint(x: 0, y: headerRect.origin.y - self.rightTableView.contentInset.top)
                self.rightTableView.setContentOffset(topOfHeader, animated: true)
                
                
                self.selectIndex = self.indexpath.section
                self.leftTableView.scrollToRow(at: IndexPath(row: self.selectIndex, section: 0), at: .top, animated: true)
            }
        }
//        storeVM.requestData(parameters: storeId) {
//            self.storeModel = self.storeVM.store
//        }
    }
}

//MARK:- 遵守delegate和DataSource协议
extension OrderFoodViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if rightTableView == tableView  {
            
            print("------\(goodsListVM.goodsGroups.count)-------")
            return goodsListVM.goodsGroups.count
            
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if leftTableView == tableView {
            
            return goodsListVM.goodsGroups.count
        }
        else if rightTableView == tableView {
            let group = goodsListVM.goodsGroups[section]
            
            print(group.goods.count)
            return group.goods.count
        }
        else {
            return orderArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("开始设置商品CELL")
        if leftTableView == tableView {
            //取出数据模型
            let group = goodsListVM.goodsGroups[indexPath.item] 
            
            //取出cell
            let cell = tableView.dequeueReusableCell(withIdentifier: leftTableViewCellID, for: indexPath) as! LeftTableViewCell
            
            //对cell模型进行赋值
            cell.group = group
            //设置cell属性
            cell.backgroundColor = UIColor(r: 245, g: 245, b: 245)
            return cell
        }
        else if rightTableView == tableView {
            
            //获取模型数据
            let goods = goodsListVM.goodsGroups[indexPath.section].goods[indexPath.row]
            
            //获取cell
            let cell = tableView.dequeueReusableCell(withIdentifier: rightTableViewCellID) as! RightTableViewCell
            
            //对cell模型进行赋值
            cell.goods = goods
            cell.addBtn.tag = indexPath.row + (indexPath.section * 10)
            cell.subBtn.tag = cell.addBtn.tag
            //给righttableview添加代理
            cell.delegate = self
            return cell
        }
        else {
            //给购物车添加数据
            //获取模型数据
            let goods = orderArray[indexPath.row]
            //获取cell
            let cell = tableView.dequeueReusableCell(withIdentifier: goodsListTableViewCellID, for: indexPath) as! GoodsListTableViewCell
            //对cell进行赋值
            cell.goods = goods
            cell.GoodsAddBtn.tag = indexPath.row
            cell.GoodsSubBtn.tag = cell.GoodsAddBtn.tag
            //添加代理
            cell.delegate = self 
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
            //设置header的数据
            headerView.nameLabel.text = goodsListVM.goodsGroups[section].categoryName
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
    func ClickTheButton(tableViewCell: RightTableViewCell, goodsNum: Int, section: Int, row: Int, tag: Bool) {
        //获取对应模型数据
        let currentGoodsModel : GoodsModel = goodsListVM.goodsGroups[section].goods[row]
        currentGoodsModel.orderCount = goodsNum
        currentGoodsModel.section = section
        currentGoodsModel.row = row
        //在此处计算总金额，总获得总金额传给shopcart，从而对shopcart视图显示进行相应设置
        let goodsPrice = currentGoodsModel.goodsPrice
        if tag{
            currentCost += goodsPrice
        }
        else{
            currentCost -= goodsPrice
        }
        shoppingCart.setupStatus(totalPrice: currentCost)
        
        //对订单数据进行操作
        if goodsNum == 0 {
            //说明一定是点击了减号且该商品数量为0，则应将其从订单数组中移除
            var count : Int = 0
            for model in orderArray{
                if model.goodsId == currentGoodsModel.goodsId{
                    orderArray.remove(at: count)
                    //订单数组改变，在此处更新数据源，也可统一在购物车见面弹出时重新加载数据
                    return
                }
                count += 1
            }
        }
        else{
            for model in orderArray{
                if model.goodsId == currentGoodsModel.goodsId{
                    model.orderCount = currentGoodsModel.orderCount
                    //订单数组改变，在此处更新数据源，也可统一在购物车见面弹出时重新加载数据
                    return
                }
            }
            orderArray.append(currentGoodsModel)
            //订单数组改变，在此处更新数据源，也可统一在购物车见面弹出时重新加载数据
        }
    }
}

extension OrderFoodViewController:GoodsListDelegate{
    func ClickTheButton(tableViewCell: GoodsListTableViewCell, goodsNum: Int, section: Int, row: Int, tag: Int, flag: Bool) {
        //计算当前总金额
        let goodsPrice = orderArray[tag].goodsPrice
        if flag{
            currentCost += goodsPrice
        }
        else{
            currentCost -= goodsPrice
        }
        shoppingCart.setupStatus(totalPrice: currentCost)
        //更改订单列表数据
        if goodsNum == 0{
            orderArray.remove(at: tag)
        }
        else{
            orderArray[tag].orderCount = goodsNum
        }
        //更改商品列表数据
        goodsListVM.goodsGroups[section].goods[row].orderCount = goodsNum
        //更新购物车列表，商品列表
        self.rightTableView.reloadData()
        self.popTableView.reloadData()
        if orderArray.count == 0{
            hide()
        }
        
    }
}
    



//MARK:- 遵守shoppingcartdelegate
extension OrderFoodViewController:ShoppingCartDelegate{
    func ClickPayButton(View: ShoppingCart) {
        if USERID == 0{
            UIAlertController.showConfirm(message: "请先登录！", confirm: { (_) in
                let vc = UIStoryboard(name: "Logon", bundle: nil).instantiateInitialViewController() as! LogonViewController
                self.navigationItem.backBarButtonItem?.title = "支付"
                self.navigationController?.pushViewController(vc, animated: true)
            })
        }
        else{
            //print(currentCost)
            totalPrice = currentCost
            totalPrice += storeModel.deliveryCost
            //let deliveryCost = storeModel.deliveryCost
            self.goOrderDetail()
        }
        
       
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
            self.popView.frame.origin.y = self.maskView.frame.height - popTableViewH - popHeaderViewH
        })
        clickShopCartFlag = 1
    }
    private func hide(){
        UIView.animate(withDuration: 0.3, animations: {
            self.popView.frame.origin.y = self.maskView.frame.height
            self.maskView.isHidden = true
        })
        clickShopCartFlag = 0
    }
    @objc private func emptyOrderArray(){
        orderArray.removeAll()
        for group in goodsListVM.goodsGroups{
            for model in group.goods{
                model.orderCount = 0
            }
        }
        currentCost = 0
        shoppingCart.setupStatus(totalPrice: currentCost)
        self.rightTableView.reloadData()
        self.popTableView.reloadData()
        hide()
    }
    //跳转到订单详情页面
    private func goOrderDetail(){
        //获取订单详情页面控制器
        let vc = PayFoodsViewController()
        let model = OrderModel()
        //对model进行赋值
        let currentDate = NSDate.getCurrentTime()
        let orderid = "\(currentDate)" + "\(storeModel.storeId)" //+ "\(user_id)"
        model.orderId = orderid
        model.userId = USERID
        model.orderStatus = 0
        model.commentFlag = 0
        model.storeId = storeModel.storeId
        model.storeName = storeModel.storeName
        model.orderTime = String(describing: NSDate(timeIntervalSince1970: Double(currentDate)))
        model.address = "默认地址"
        model.deliverySide = "商家配送"
        model.payWay = "支付宝"
        model.deliveryCost = storeModel.deliveryCost
        model.preferentialPrice = 0
        model.payCost = totalPrice
        model.goodsList = orderArray
        //传递数据
        vc.orderModel = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension OrderFoodViewController : StoreDelegate{
    func findGoods(viewController: StoreViewController, indexpath: IndexPath) {
        print(indexpath)
        let headerRect = rightTableView.rectForRow(at: indexpath)
        let topOfHeader = CGPoint(x: 0, y: headerRect.origin.y - rightTableView.contentInset.top)
        rightTableView.setContentOffset(topOfHeader, animated: true)
        
        
        selectIndex = indexpath.section
        leftTableView.scrollToRow(at: IndexPath(row: selectIndex, section: 0), at: .top, animated: true)
        //rightTableView.scrollToRow(at: indexpath, at: .top, animated: true)
    }
    
    
}















