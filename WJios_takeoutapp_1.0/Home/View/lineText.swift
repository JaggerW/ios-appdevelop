//
//  lineText.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 01/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

class lineText: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var label: UILabel!
    
//    static func newInstance() -> lineText?{
//        let nib = Bundle.main.loadNibNamed("lineText", owner: nil, options: nil)
//        if let view = nib?.first as? lineText{
//            return view
//        }
//        return nil
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension lineText{
    private func initViewFromNib(){
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "lineText", bundle: bundle)
        self.view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.view.frame = bounds
        self.addSubview(view)
    }
}







