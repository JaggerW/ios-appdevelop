//
//  TableViewCell.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 29/11/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var storeIcon: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var star: UIImageView!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var saleNum: UILabel!
    @IBOutlet weak var distributionSide: UILabel!
    @IBOutlet weak var distributionTimeRange: UILabel!
    @IBOutlet weak var distributionStartPrice: UILabel!
    @IBOutlet weak var distributionCost: UILabel!
    @IBOutlet weak var storeDistance: UILabel!
    @IBOutlet weak var storeActivityIcon1: UIImageView!
    @IBOutlet weak var storeActivityLable1: UILabel!
    @IBOutlet weak var storeActivityIcon2: UIImageView!
    @IBOutlet weak var storeActivityLable2: UILabel!
    
    //MARK:- 定义模型属性
    var store: StoreListModel?{
        didSet {
            guard let store = store else { return }
            //对控件属性进行赋值
            storeName.text = store.storeName
            point.text = String(store.storeGrade)
            saleNum.text = "月销售\(store.salesAmount)份"
            distributionSide.text = "商家配送"
            distributionTimeRange.text = "11:00--21:00"
            distributionStartPrice.text = "\(store.sendingPrice)元起送"
            let deliveryCost = store.deliveryCost
            if deliveryCost - Float(Int(deliveryCost)) == 0.0{
                distributionCost.text = "配送费\(Int(store.deliveryCost))元"
            }
            else{
                distributionCost.text = "配送费\(store.deliveryCost)元"
            }
            let distance = store.storeDistance
            if distance >= 1000{
                storeDistance.text = "距离\(distance / 1000)km"
            }
            else{
                storeDistance.text = "距离\(distance)m"
            }
            storeActivityLable1.text = store.storeActivityTip1
            storeActivityLable2.text = store.storeActivityTip2
            //显示商铺图片
            guard let storeIconURL = URL(string: store.storeImage) else {return}
            storeIcon.kf.setImage(with: storeIconURL)
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
