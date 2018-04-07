//
//  GoodsListTableViewCell.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 28/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

protocol GoodsListDelegate : class {
    func ClickTheButton(tableViewCell: GoodsListTableViewCell,goodsNum: Int,section: Int,row: Int,tag: Int,flag: Bool)
}

class GoodsListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var GoodsNameLabel: UILabel!
    
    @IBOutlet weak var GoodsPriceLabel: UILabel!
    
    @IBOutlet weak var GoodsNumLabel: UILabel!
    
    @IBOutlet weak var GoodsAddBtn: UIButton!
    
    @IBOutlet weak var GoodsSubBtn: UIButton!
    
    var orderCount: Int = 0{
        didSet{
            GoodsNumLabel.text = String(orderCount)
        }
    }
    
    var section : Int = 0
    var row : Int = 0
    
    var goods : GoodsModel?{
        didSet{
            guard let goods = goods else {return}
            GoodsNameLabel.text = goods.goodsName
            section = goods.section
            row = goods.row
            let price = goods.goodsPrice
            if price - Float(Int(price)) == 0.0{
                GoodsPriceLabel.text = "\(Int(price))"
            }
            else{
                GoodsPriceLabel.text = "\(goods.goodsPrice)"
            }
            GoodsNumLabel.text = "\(goods.orderCount)"
            orderCount = goods.orderCount
        }
    }
    
    //定义代理
    weak var delegate:GoodsListDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addGoods(_ sender: Any) {
        let tag: Int = GoodsAddBtn.tag
        orderCount += 1
        delegate?.ClickTheButton(tableViewCell: self, goodsNum: orderCount, section: section, row: row, tag: tag, flag: true)
        
    }
    @IBAction func subGoods(_ sender: Any) {
        let tag: Int = GoodsSubBtn.tag
        orderCount -= 1
        delegate?.ClickTheButton(tableViewCell: self, goodsNum: orderCount, section: section, row: row, tag: tag, flag: false)
    }
    
    
    
    
    
}
