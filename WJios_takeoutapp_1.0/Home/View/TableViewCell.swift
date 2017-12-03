//
//  TableViewCell.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 29/11/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
