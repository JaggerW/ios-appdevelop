//
//  RightTableViewCell.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 07/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit
import Kingfisher

protocol OrderFoodDelegate : class {
    func ClickTheButton(tableViewCell: RightTableViewCell,goodsNum: Int,section : Int,row : Int,tag: Bool)
}

class RightTableViewCell: UITableViewCell {

    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var salesAmount: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var foodNumLabel: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var subBtn: UIButton!
    
    //商品数量
    var num : Int = 0{
        didSet{
            if num == 0{
                foodNumLabel.text = "0"
                foodNumLabel.isHidden = true
                subBtn.isHidden = true
                subBtn.isEnabled = false
            }
            else{
                foodNumLabel.text = String(num)
                foodNumLabel.isHidden = false
                subBtn.isHidden = false
                subBtn.isEnabled = true
            }
        }
    }
    //定义代理
    weak var delegate:OrderFoodDelegate?
    //定义商品模型
    var goods : GoodsModel?{
        didSet{
            guard let goods = goods else {return}
            
            foodNameLabel.text = goods.goodsName
            let price = goods.goodsPrice
            if price - Float(Int(price)) == 0.0{
                foodPrice.text = "\(Int(price))"
            }
            else{
                foodPrice.text = "\(goods.goodsPrice)"
            }
            salesAmount.text = "月销售\(goods.goodsSalesAmount)份"
            num = goods.orderCount
            //显示商铺图片
            guard let foodIconURL = URL(string: goods.goodsImage) else {return}
            foodImage.kf.setImage(with: foodIconURL)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        foodNumLabel.text = "0"
        subBtn.isHidden = true
        subBtn.isEnabled = false
        foodNumLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func clickAdd(_ sender: Any) {
        let tag: Int = addBtn.tag
        let section: Int = tag / 10
        let row: Int = tag % 10
        num += 1
        //通知代理
        self.delegate?.ClickTheButton(tableViewCell: self, goodsNum: num, section: section, row: row, tag: true)
    }
    
    
    @IBAction func clickSub(_ sender: Any) {
        let tag: Int = addBtn.tag
        let section: Int = tag / 10
        let row: Int = tag % 10
        num -= 1
        //通知代理
        self.delegate?.ClickTheButton(tableViewCell: self, goodsNum: num, section: section, row: row, tag: false)
    }
    
}
