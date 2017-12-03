//
//  FoodCollectionViewCell.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 01/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var getIn: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
