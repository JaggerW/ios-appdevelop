//
//  CommentTableViewcell.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 08/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    //MARK:- 定义outlet属性
    @IBOutlet weak var ImageContentView: UIView!
    
    
    
    //MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //MARK:- 设置图片评论
    
        let imageGap: CGFloat = 10
        let imageRightGap: CGFloat = 48
        let imageLeftGap: CGFloat = 20
        let imageContentViewW = kScreenW - imageLeftGap - imageRightGap
        let imageW = (imageContentViewW - 2 * imageGap) / 3
        let imageH = imageW
        let imageContentViewH = imageH
        ImageContentView.bounds.size.width = imageContentViewW
        ImageContentView.bounds.size.height = imageContentViewH
        for i in 0..<3{
            let imageX = CGFloat(i) * (imageW + imageGap)
            let rect = CGRect(x: imageX, y: 0, width: imageW, height: imageH)
            let image = UIImageView.init(frame: rect)
            image.image = UIImage(named: "widget_supper")
            self.ImageContentView.addSubview(image)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}



