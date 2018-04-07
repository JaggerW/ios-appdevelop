//
//  ShopCartView.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 28/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let goodsListTableViewCellID = "goodsListTableViewCellID"
var count :Int = 0

class ShopCartView: UIView {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBAction func emptyOrderArray(_ sender: Any) {
    }
    //懒加载poptableview
    private lazy var popTableView: UITableView = {
        let rect = CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: 320)
        let tableView = UITableView(frame: rect)
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
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
        
        
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ShopCartView{
    private func setupUI(){
        self.backgroundColor = UIColor(white: 0, alpha: 0.3)
        self.isHidden = true
        //给cartView添加手势
        self.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.MaskViewClick(tapGes:)))
        self.addGestureRecognizer(tapGes)
        //添加tableview
        self.addSubview(popTableView)
        
        
    }
    
    @objc private func MaskViewClick(tapGes: UITapGestureRecognizer){
        UIView.animate(withDuration:0.2, animations: {
            self.popTableView.frame.origin.y = self.bounds.height
            self.isHidden = true
        }, completion: nil)
        
        
    }
}

extension ShopCartView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = popTableView.dequeueReusableCell(withIdentifier: goodsListTableViewCellID, for: indexPath)
        return cell
    }
    
    
}

extension ShopCartView{
    private func initViewFromNib(){
        let bundle = Bundle(for: type(of:self))
        let nib = UINib(nibName: "ShopCartView", bundle: bundle)
        self.tableView = nib.instantiate(withOwner: self, options: nil)[0] as! UITableView
        self.tableView.frame = bounds
        self.addSubview(tableView)
    }
}

//MARK:- 对外暴露方法
extension ShopCartView{
    //弹出
    func showView(){
        
        UIView.animate(withDuration:0.2, animations: {
            self.isHidden = false
            self.popTableView.frame.origin.y = self.bounds.height - 320
        }, completion: nil)
    }
    
    //收回
    func hideView(){
        UIView.animate(withDuration:0.2, animations: {
            self.popTableView.frame.origin.y = self.bounds.height
            self.isHidden = true
        }, completion: nil)
    }
}














