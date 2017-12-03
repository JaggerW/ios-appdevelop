//
//  OrderTableViewCell.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 29/11/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var orderTimeDay: UILabel!
    @IBOutlet weak var orderTimeHour: UILabel!
    @IBOutlet weak var allCost: UILabel!
    
    @IBOutlet weak var againButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func button(_ sender: Any) {
        orderStatus.textColor = UIColor.blue
    }
}
