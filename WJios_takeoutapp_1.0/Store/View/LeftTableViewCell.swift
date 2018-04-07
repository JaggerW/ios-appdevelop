//
//  LeftTableViewCell.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 07/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

class LeftTableViewCell: UITableViewCell {
    //MARK:- 设置outlet属性
    
    @IBOutlet weak var label: UILabel!
    

    //MARK:- 系统函数
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var group : GoodsGroup?{
        didSet {
            label.text = group?.categoryName
        }
    }
    
}
