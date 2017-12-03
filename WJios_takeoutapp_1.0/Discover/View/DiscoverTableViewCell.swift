//
//  DiscoverTableViewCell.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 01/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit
//自定义常量
//private let rightleftSpace:CGFloat = 13
//private let collectionViewW:CGFloat = kScreenW - rightleftSpace * 2
//private let collectionCellSpaceW:CGFloat = 5
//private let collectionCellW = (collectionViewW - 2 * collectionCellSpaceW) / 3
//private let collectionCellH:CGFloat = collectionViewW * 1.7
//private let collectionViewH:CGFloat = collectionCellH
//private let identifier = "discoverFoodCollectionCell"
//
class DiscoverTableViewCell: UITableViewCell {
//    //与xib中视图控件进行关联
//    @IBOutlet var tableviewcell: DiscoverTableViewCell!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
//
//
//    //MARK:- 懒加载
//    private lazy var collectionView: UICollectionView = {
//        let rect = CGRect(x: 8, y: 42, width: collectionViewW, height: collectionViewH)
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: collectionCellW, height: collectionCellH)
//        layout.minimumLineSpacing = 5
//        layout.minimumInteritemSpacing = 0
//        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
//
//        let collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
//
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        let nib = UINib(nibName: "FoodCollectionViewCell", bundle: nil)
//        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
//        collectionView.backgroundColor = UIColor.white
//        return collectionView
//    }()
//
//    //MARK:- 重写构造函数
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        //设置UI
//        setupUI()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//extension DiscoverTableViewCell{
//    //MARK:- 设置UI
//    private func setupUI(){
//        //0. 从xib中载入view
//        initViewFromNib()
//        //1. 设置collectionveiw
//        self.addSubview(collectionView)
//    }
//
//    private func initViewFromNib(){
//        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: "DiscoverTableViewCell", bundle: bundle)
//        self.tableviewcell = nib.instantiate(withOwner: self, options: nil)[0] as! DiscoverTableViewCell
//        self.tableviewcell.frame = bounds
//        self.addSubview(tableviewcell)
//    }
//
//
//}
//
//extension DiscoverTableViewCell:UICollectionViewDataSource,UICollectionViewDelegate{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
//        cell.bounds.size.width = collectionCellW
//        cell.bounds.size.height = collectionCellH
//        return cell
//    }
//
//
//}

