//
//  StoreHeaderView.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 07/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

class StoreHeaderView: UIView {
    
    @IBOutlet var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:- 从nib中调取视图
extension StoreHeaderView{
    private func initViewFromNib(){
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "StoreHeaderView", bundle: bundle)
        self.view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.view.frame = bounds
        self.addSubview(view)
    }
}






