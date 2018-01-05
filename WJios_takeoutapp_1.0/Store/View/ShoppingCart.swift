//
//  ShoppingCart.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 26/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

protocol ShoppingCartDelegate : class {
    func ClickPayButton(View: ShoppingCart)
    func ClickCartView(View: ShoppingCart)
}

class ShoppingCart: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var cartView: UIView!
    
    @IBOutlet weak var cartEmpty: UILabel!
    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    weak var delegate:ShoppingCartDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
        
        //初始化设置
        priceLabel.isHidden = true
        tipLabel.isHidden = true
        payBtn.isEnabled = false
        payBtn.backgroundColor = UIColor.darkGray
        payBtn.setTitle("¥20起送", for: .normal)
        payBtn.setTitleColor(UIColor.lightGray, for: .normal)
        
        //给cartView添加手势
        cartView.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.CartViewClick(tapGes:)))
        cartView.addGestureRecognizer(tapGes)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func PayBtn(_ sender: Any) {
        //通知代理
        self.delegate?.ClickPayButton(View: self)
    }
    
    
}

extension ShoppingCart{
    private func initViewFromNib(){
        let bundle = Bundle(for: type(of:self))
        let nib = UINib(nibName: "ShoppingCart", bundle: bundle)
        self.view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.view.frame = bounds
        self.addSubview(view)
    }
    
    @objc private func CartViewClick(tapGes: UITapGestureRecognizer){
        //通知代理
        self.delegate?.ClickCartView(View: self)
    }
}

//对外暴露函数
extension ShoppingCart{
    //设置去支付状态
    func setupPay(currentPrice: Int){
        cartEmpty.isHidden = true
        priceLabel.isHidden = false
        priceLabel.text = "¥\(currentPrice)"
        tipLabel.isHidden = false
        if payBtn.isEnabled == false {
            payBtn.isEnabled = true
        }
        
        payBtn.backgroundColor = UIColor.green
        payBtn.setTitle("去支付", for: .normal)
        payBtn.setTitleColor(UIColor.white, for: .normal)
        
        
    }
    //未到起送价格，需继续添加
    func setupContinueAdd(currentPrice: Int,haichaPrice: Int){
        cartEmpty.isHidden = true
        priceLabel.isHidden = false
        priceLabel.text = "¥\(currentPrice)"
        tipLabel.isHidden = false
        if payBtn.isEnabled == true{
            payBtn.isEnabled = false
        }
        
        payBtn.backgroundColor = UIColor.darkGray
        payBtn.setTitle("还差¥\(haichaPrice)起送", for: .normal)
        payBtn.setTitleColor(UIColor.lightGray, for: .normal)
    }
    //初始状态
    func setupInit(){
        cartEmpty.isHidden = false
        priceLabel.isHidden = true
        tipLabel.isHidden = true
        if payBtn.isEnabled == true{
            payBtn.isEnabled = false
        }
        
        payBtn.backgroundColor = UIColor.darkGray
        payBtn.setTitle("¥20起送", for: .normal)
        payBtn.setTitleColor(UIColor.lightGray, for: .normal)
    }
}











