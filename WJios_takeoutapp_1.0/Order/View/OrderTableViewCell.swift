//
//  OrderTableViewCell.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 29/11/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

protocol OrderTableViewCellDelegate : class {
    func ClickTheButton(cellView: OrderTableViewCell,IndexRow: Int) -> Int
    
    func CancelTheOrder(cellView: OrderTableViewCell,IndexRow: Int)
    
    func LongPress(cellView : OrderTableViewCell, indexPath : IndexPath)
}

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var allCost: UILabel!
    @IBOutlet weak var againButton: UIButton!
    var status : Int = 0{
        didSet{
            if status == 0{
                orderStatus.text = "正在配送中"
                againButton.setTitle("确认收货", for: .normal)
                againButton.isHidden = false
                cancel.isHidden = false
            }
            else if status == 1{
                orderStatus.text = "订单已完成"
                againButton.setTitle("再来一单", for: .normal)
                cancel.isHidden = true
            }
            else{
                orderStatus.text = "订单被取消"
                againButton.isHidden = true
                cancel.isHidden = true
            }
        }
    }
    //定义属性
    private var indexRow = 0
    //订单模型
    var order : OrderModel?{
        didSet{
            guard let order = order else{return}
            //对cell中视图赋值
            storeName.text = order.storeName
            orderTime.text = order.orderTime
            allCost.text = "\(order.payCost)"
            status = order.orderStatus
        }
    }
    
    var indexPath = IndexPath.init()
    
    weak var delegate:OrderTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //添加手势
        let guesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(_:)))
        guesture.minimumPressDuration = 1.0
        guesture.allowableMovement = 20.0
        self.addGestureRecognizer(guesture)
    }
    
    @objc func longPress(_ gusture : UILongPressGestureRecognizer){
        if gusture.state == UIGestureRecognizerState.began{
            //通知代理
            self.delegate?.LongPress(cellView: self, indexPath: indexPath)
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func button(_ sender: Any) {
        if (delegate?.ClickTheButton(cellView: self, IndexRow: againButton.tag))! == 1{
            status = 1
        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
        delegate?.CancelTheOrder(cellView: self, IndexRow: againButton.tag)
        status = 2
        
    }
    
}


