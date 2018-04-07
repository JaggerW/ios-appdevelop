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
    
    //定义属性
    var sendingPrice : Int = 0{
        didSet{
            payBtn.setTitle("¥\(sendingPrice)起送", for: .normal)
        }
    }
    var deliveryCost : Float = 0{
        didSet{
            if deliveryCost - Float(Int(deliveryCost)) == 0.0{
                tipLabel.text = "另需配送费\(Int(deliveryCost))元"
            }
            else{
                tipLabel.text = "另需配送费\(deliveryCost)元"
            }
        }
    }
    //设置代理
    weak var delegate:ShoppingCartDelegate?
    //初始化函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
        
        //初始化设置
        setupInit()
        
        //给cartView添加手势
        cartView.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.CartViewClick(tapGes:)))
        cartView.addGestureRecognizer(tapGes)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //添加按钮相应
    @IBAction func PayBtn(_ sender: Any) {
        //通知代理
        self.delegate?.ClickPayButton(View: self)
    }
    
    
}

extension ShoppingCart{
    //从nib中添加视图
    private func initViewFromNib(){
        let bundle = Bundle(for: type(of:self))
        let nib = UINib(nibName: "ShoppingCart", bundle: bundle)
        self.view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.view.frame = bounds
        self.addSubview(view)
    }
    //添加手势
    @objc private func CartViewClick(tapGes: UITapGestureRecognizer){
        //通知代理
        self.delegate?.ClickCartView(View: self)
    }
}

//对外暴露函数
extension ShoppingCart{
    //设置购物车状态
    func setupStatus(totalPrice: Float){
        /*
         * if 总金额大于等于起送价 进行可支付相应设置
         * else 为不可支付相应设置，同时计算差价为起送价-总金额
         */
        if totalPrice >= Float(sendingPrice){
            //可支付
            cartEmpty.isHidden = true
            priceLabel.isHidden = false
            if totalPrice - Float(Int(totalPrice)) == 0{
                priceLabel.text = "¥\(Int(totalPrice))"
            }
            else{
                priceLabel.text = "¥\(totalPrice)"
            }
            tipLabel.isHidden = false
            if payBtn.isEnabled == false {
                payBtn.isEnabled = true
            }
            
            payBtn.backgroundColor = UIColor.green
            payBtn.setTitle("去支付", for: .normal)
            payBtn.setTitleColor(UIColor.white, for: .normal)
        }
        else if totalPrice == 0{
            //购物车为空,初始化设置
            setupInit()
            
        }
        else{
            //不到起送价不可支付但购物车中有商品
            cartEmpty.isHidden = true
            if totalPrice - Float(Int(totalPrice)) == 0{
                priceLabel.text = "¥\(Int(totalPrice))"
            }
            else{
                priceLabel.text = "¥\(totalPrice)"
            }
            priceLabel.isHidden = false
            tipLabel.isHidden = false
            if payBtn.isEnabled == true{
                payBtn.isEnabled = false
            }
            let haichaPrice = Float(sendingPrice) - totalPrice
            if haichaPrice - Float(Int(haichaPrice)) == 0{
                payBtn.setTitle("还差¥\(Int(haichaPrice))", for: .normal)
            }
            else{
                
                payBtn.setTitle("还差¥\(haichaPrice)起送", for: .normal)
            }
            payBtn.backgroundColor = UIColor.darkGray
            payBtn.setTitleColor(UIColor.lightGray, for: .normal)
        }
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
        payBtn.setTitle("¥\(sendingPrice)起送", for: .normal)
        payBtn.setTitleColor(UIColor.lightGray, for: .normal)
    }
}











