//
//  AddressTableViewCell.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 14/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

protocol AddressTableViewCellDelegate : class {
    func ModifyAddress(viewCell: AddressTableViewCell,index: Int)
    func LongPress(cellView : AddressTableViewCell, indexPath : IndexPath)
}

class AddressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var addressLable: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var modify: UIImageView!
    
    var model : AddressModel?{
        didSet{
            guard let model = model else{return}
            addressLable.text = model.address
            nameLabel.text = model.userName
            telLabel.text = model.userTel
        }
    }
    var delegate: AddressTableViewCellDelegate?
    
    var indexPath = IndexPath.init()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        modify.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.Modify(tapGes:)))
        modify.addGestureRecognizer(tapGes)
        
        //添加手势
        let guesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(_:)))
        guesture.minimumPressDuration = 1.0
        guesture.allowableMovement = 20.0
        self.addGestureRecognizer(guesture)
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func longPress(_ gusture : UILongPressGestureRecognizer){
        if gusture.state == UIGestureRecognizerState.began{
            //通知代理
            self.delegate?.LongPress(cellView: self, indexPath: indexPath)
            
        }
    }

    
    @objc private func Modify(tapGes: UITapGestureRecognizer){
        //通知代理
        print(modify.tag)
        delegate?.ModifyAddress(viewCell: self, index: modify.tag)
    }
    
    
    
}
