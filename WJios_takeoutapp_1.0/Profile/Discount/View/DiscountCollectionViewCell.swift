//
//  DiscountCollectionViewCell.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 13/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

protocol DiscountCollectionViewCellDelegate: class {
    func ClickTheButton(viewCell: DiscountCollectionViewCell,StoreID: Int)
}

class DiscountCollectionViewCell: UICollectionViewCell {
    //定义属性
    @IBOutlet weak var creditsCost: UILabel!
    @IBOutlet weak var button: UIButton!
    weak var delegate:DiscountCollectionViewCellDelegate?

    var StoreID: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func toStore(_ sender: Any) {
        //通知代理
        delegate?.ClickTheButton(viewCell: self, StoreID: StoreID)
    }
    
}
