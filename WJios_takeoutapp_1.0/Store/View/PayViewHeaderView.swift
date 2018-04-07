//
//  PayViewHeaderView.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 21/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit

protocol PayViewHeaderViewDelegate : class {
    func ClickPayButton(headerView: PayViewHeaderView)
    func ClickChooseAddress(headerView: PayViewHeaderView)
}

class PayViewHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var storeImage: UIImageView!
    
    @IBOutlet weak var addressLabel: UIButton!
    
    var totalPrice : Float = 0
    
    var delegate:PayViewHeaderViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func ChooseAddress(_ sender: Any) {
        self.delegate?.ClickChooseAddress(headerView: self)
    }
    
    @IBAction func Pay(_ sender: Any) {
        
        self.delegate?.ClickPayButton(headerView: self)
        
    }
    
}
