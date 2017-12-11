//
//  RightTableHeaderView.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 07/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

class RightTableHeaderView: UIView {
    
    lazy var nameLabel = UILabel()
    private let lineH:CGFloat = 0.5
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        nameLabel.frame = CGRect(x: 8, y: lineH, width: 200, height: frame.height - lineH * 2)
        nameLabel.font = UIFont.systemFont(ofSize: 13)
        nameLabel.textColor = UIColor.darkGray
        addSubview(nameLabel)
        
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 8, y: frame.height - lineH, width: frame.width - 8, height: lineH)
        addSubview(bottomLine)
        
        //1.添加底线
        let topLine = UIView()
        topLine.backgroundColor = UIColor.lightGray
        topLine.frame = CGRect(x: 8, y: 0, width: frame.width - 8, height: lineH)
        addSubview(topLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

