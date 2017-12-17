//
//  ProfileTableHeaderView.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 12/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let collectionCellW: CGFloat = (kScreenW - 2) / 3
private let collectionCellH: CGFloat = collectionCellW * 2 / 3
private let headerViewH: CGFloat = 100
private let buttonCollectionViewCellID = "buttonCollectionViewCellID"

protocol ProfileTableHeaderDelegate : class {
    func SelectItem(headerView: ProfileTableHeaderView,Index: Int,Num: String)
    func ClickHeader(headerView: ProfileTableHeaderView)
}

class ProfileTableHeaderView: UIView {
    
    //MARK:- 定义属性
    
    @IBOutlet var view: UIView!
    weak var delegate: ProfileTableHeaderDelegate?
    
    //MARK:- 懒加载
    //collectionview
    private lazy var buttonCollectionView: UICollectionView = {
        //设置layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionCellW, height: collectionCellH)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        //创建collection
        let rect = CGRect(x: 0, y: headerViewH, width: kScreenW, height: collectionCellH)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        //设置代理
        collectionView.dataSource = self
        collectionView.delegate = self
        //注册cell
        let nib = UINib(nibName: "ProfileCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: buttonCollectionViewCellID)
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        
        return collectionView
    }()
    //[String]
    var balanceNum: Float = 15.00
    var discountNum: Int = 5
    var creditsNum: Int = 100
    private lazy var nameString: [(String,String,String)] = {
        let nameString = [("钱包",String(balanceNum),"元"),("优惠",String(discountNum),"个"),("积分",String(creditsNum),"分")]
        return nameString
    }()
    
    //MARK:- 系统回调函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //设置ui
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:- 设置UI
extension ProfileTableHeaderView{
    private func setupUI(){
        //initViewFromNib
        initViewFromNib()
        //添加collectionview
        self.addSubview(buttonCollectionView)
    }
    
    private func initViewFromNib(){
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ProfileTableHeaderView", bundle: bundle)
        self.view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.view.frame = bounds
        //添加手势
        view.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.headerViewClick(tapGes:)))
        view.addGestureRecognizer(tapGes)
        self.addSubview(view)
    }
}

//MARK:- 遵守代理设置数据源
extension ProfileTableHeaderView:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: buttonCollectionViewCellID, for: indexPath) as! ProfileCollectionViewCell
        cell.nameLabel.text = nameString[indexPath.row].0
        cell.numLabel.text = nameString[indexPath.row].1
        cell.unitLabel.text = nameString[indexPath.row].2
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //通知代理，并传递index
        delegate?.SelectItem(headerView: self, Index: indexPath.item, Num: nameString[indexPath.item].1)
    }
    
}

//MARK:- 监听点击
extension ProfileTableHeaderView{
    @objc private func headerViewClick(tapGes: UITapGestureRecognizer){
        //通知代理
        delegate?.ClickHeader(headerView: self)
    }
}















