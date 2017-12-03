//
//  CollectionViewCell.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 30/11/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

  
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var activityDetailLabel: UILabel!
    @IBOutlet weak var activityImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
