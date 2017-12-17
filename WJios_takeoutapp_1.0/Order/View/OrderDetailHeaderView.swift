//
//  OrderDetailHeaderView.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 10/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

protocol OrderDetailHeaderDelegate : class {
    func ClickTheButton(headerView: OrderDetailHeaderView)
}

class OrderDetailHeaderView: UICollectionReusableView {
    
    weak var delegate : OrderDetailHeaderDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func AgainButton(_ sender: Any) {
        //通知代理
        delegate?.ClickTheButton(headerView: self)
    }
}
