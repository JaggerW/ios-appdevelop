//
//  RightTableViewCell.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 07/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

protocol OrderFoodDelegate : class {
    func ClickAddButton(tableViewCell: RightTableViewCell,goodsNum: Int,goodsPrice: Int,foodName: String)
    func ClickSubButton(tableViewCell: RightTableViewCell,goodsNum: Int,goodsPrice: Int)
}

class RightTableViewCell: UITableViewCell {

    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodNumLabel: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var subBtn: UIButton!
    
    var numArray = [[0,0,0,0,0],[0,0,0],[0,0,0,0,0,0,0,0],[0,0,0],[0,0,0],[0,0]]
    
    weak var delegate:OrderFoodDelegate?
    
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
        let tag = addBtn.tag
        let section = tag / 10
        let row = tag % 10
        
        var num:Int = numArray[section][row]
        
        num += 1
        if num == 1{
            //foodNumLabel.text = "1"
            foodNumLabel.isHidden = false
            subBtn.isEnabled = true
            subBtn.isHidden = false
        }
        
        foodNumLabel.text = String(num)
        numArray[section][row] = num
        print(foodNumLabel.text!)
        print(addBtn.tag)
        
        //通知代理
        self.delegate?.ClickAddButton(tableViewCell: self, goodsNum: num, goodsPrice: 15, foodName: foodNameLabel.text!)
    }
    
    
    @IBAction func clickSub(_ sender: Any) {
        let tag = addBtn.tag
        let section = tag / 10
        let row = tag % 10
        
        var num:Int = numArray[section][row]
        if num == 1{
            //foodNumLabel.text = "1"
            foodNumLabel.isHidden = true
            subBtn.isEnabled = false
            subBtn.isHidden = true
        }
        num -= 1
        foodNumLabel.text = String(num)
        numArray[section][row] = num
        print(foodNumLabel.text!)
        print(subBtn.tag)
        //通知代理
        self.delegate?.ClickSubButton(tableViewCell: self, goodsNum: num, goodsPrice: 15)
    }
    
}
