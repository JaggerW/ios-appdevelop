//
//  StoreHeaderView.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 07/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

class StoreHeaderView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var storeIcon: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeBrief: UILabel!
    @IBOutlet weak var store_icon: UIImageView!
    @IBOutlet weak var distributionSide: UILabel!
    @IBOutlet weak var icon_notice: UIImageView!
    @IBOutlet weak var storeNotice: UILabel!
    @IBOutlet weak var icon_activity1: UIImageView!
    @IBOutlet weak var storeActivityLable1: UILabel!
    @IBOutlet weak var icon_activity2: UIImageView!
    @IBOutlet weak var storeActivityLable2: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- 定义模型属性
    var store: StoreListModel?{
        didSet {
            guard let store = store else { return }
            //对控件属性进行赋值
            storeName.text = store.storeName
//            point.text = String(store.storeGrade)
//            saleNum.text = "月销售\(store.salesAmount)份"
            distributionSide.text = "商家配送"
//            distributionTimeRange.text = "11:00--21:00"
//            distributionStartPrice.text = "\(store.sendingPrice)元起送"
//            distributionCost.text = "配送费\(store.deliveryCost)元"
//            let distance = store.storeDistance
//            if distance >= 1000{
//                storeDistance.text = "距离\(distance / 1000)km"
//            }
//            else{
//                storeDistance.text = "距离\(distance)m"
//            }
            storeActivityLable1.text = store.storeActivityTip1
            storeActivityLable2.text = store.storeActivityTip2
            storeBrief.text = store.briefIntroduction
            storeNotice.text = store.storeNotice
            //显示商铺图片
            guard let storeIconURL = URL(string: store.storeImage) else {return}
            storeIcon.kf.setImage(with: storeIconURL)
        }
    }
    
    
}

//MARK:- 从nib中调取视图
extension StoreHeaderView{
    private func initViewFromNib(){
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "StoreHeaderView", bundle: bundle)
        self.view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.view.frame = bounds
        self.addSubview(view)
    }
}






