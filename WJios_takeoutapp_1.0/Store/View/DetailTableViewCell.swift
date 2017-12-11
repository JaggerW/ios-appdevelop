//
//  DetailTableViewCell.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 09/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
