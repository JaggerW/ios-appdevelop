//
//  GoodsListTableViewCell.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 28/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

class GoodsListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var GoodsNameLabel: UILabel!
    
    @IBOutlet weak var GoodsPriceLabel: UILabel!
    
    @IBOutlet weak var GoodsNumLabel: UILabel!
    
    @IBOutlet weak var GoodsAddBtn: UIButton!
    
    @IBOutlet weak var GoodsSubBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        GoodsNumLabel.text = "1"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addGoods(_ sender: Any) {
        
    }
    @IBAction func subGoods(_ sender: Any) {
        
    }
    
    
    
    
    
}
