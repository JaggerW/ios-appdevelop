//
//  OrderDetailTableFooterView.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 10/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

class OrderDetailTableFooterView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var totalCost: UILabel!
    @IBOutlet weak var label: UILabel!
    //MARK:- 自定义初始化函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //从nib加载视图
        initViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @IBAction func ClickTheBtn(_ sender: Any) {
    }
    
}

//MARK:- 从nib中引入视图
extension OrderDetailTableFooterView{
    private func initViewFromNib(){
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "OrderDetailTableFooterView", bundle: bundle)
        self.view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.view.frame = bounds
        self.addSubview(view)
    }
}
